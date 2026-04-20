/**
 * Gmail Bulk Cleanup Script
 *
 * Deploy via https://script.google.com
 * 1. Create new project
 * 2. Paste this script
 * 3. Run setup() once to create time-based trigger
 * 4. Authorize when prompted
 *
 * IMPORTANT: This script ARCHIVES emails, never deletes them.
 * Archived emails remain searchable and accessible in "All Mail".
 *
 * GmailApp has a quota: ~100 threads per batch operation,
 * and a daily limit of ~10,000 email operations for consumer accounts.
 * The script processes in small batches and re-runs via trigger.
 */

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

const CONFIG = {
  // Maximum threads to process per execution (stay within 6-min limit)
  BATCH_SIZE: 100,

  // Dry run mode: set to true to log what WOULD be archived without doing it
  DRY_RUN: false,

  // Cleanup rules: each rule has a Gmail search query and a description
  RULES: [
    {
      query: 'in:inbox category:promotions older_than:3m',
      description: 'Promotions older than 3 months',
    },
    {
      query: 'in:inbox category:social older_than:3m',
      description: 'Social notifications older than 3 months',
    },
    {
      query: 'in:inbox subject:(verification code OR OTP OR passcode OR "security code" OR "one-time") older_than:7d',
      description: 'Expired verification codes and OTPs',
    },
    {
      query: 'in:inbox category:updates older_than:6m',
      description: 'Update/transactional emails older than 6 months',
    },
    {
      query: 'in:inbox from:(noreply OR no-reply OR donotreply) older_than:6m',
      description: 'No-reply sender emails older than 6 months',
    },
    {
      query: 'in:inbox subject:(receipt OR invoice OR "order confirmed") older_than:1y',
      description: 'Old receipts and order confirmations',
    },
    {
      query: 'in:inbox is:unread older_than:1y',
      description: 'Unread emails older than 1 year',
    },
    {
      query: 'in:inbox category:forums older_than:6m',
      description: 'Forum/mailing list emails older than 6 months',
    },
  ],
};

// ---------------------------------------------------------------------------
// Main entry point
// ---------------------------------------------------------------------------

/**
 * Run cleanup across all configured rules.
 * Safe to run multiple times -- it picks up where it left off.
 */
function runCleanup() {
  const startTime = Date.now();
  const maxRuntime = 5 * 60 * 1000; // 5 minutes (leave 1 min buffer)
  let totalArchived = 0;

  for (const rule of CONFIG.RULES) {
    if (Date.now() - startTime > maxRuntime) {
      Logger.log('Approaching time limit, stopping. Will continue on next trigger.');
      break;
    }

    const archived = processRule(rule, startTime, maxRuntime);
    totalArchived += archived;
  }

  Logger.log(`=== Cleanup complete. Total threads archived this run: ${totalArchived} ===`);

  if (totalArchived === 0) {
    Logger.log('No more threads to process. Inbox is clean per current rules.');
  }
}

/**
 * Process a single cleanup rule, archiving matching threads in batches.
 */
function processRule(rule, startTime, maxRuntime) {
  let archived = 0;

  while (true) {
    if (Date.now() - startTime > maxRuntime) {
      break;
    }

    const threads = GmailApp.search(rule.query, 0, CONFIG.BATCH_SIZE);

    if (threads.length === 0) {
      break;
    }

    if (CONFIG.DRY_RUN) {
      for (const thread of threads) {
        Logger.log(`[DRY RUN] Would archive: "${thread.getFirstMessageSubject()}" from ${thread.getMessages()[0].getFrom()}`);
      }
      // In dry run, break after first batch to avoid infinite loop
      archived += threads.length;
      break;
    }

    GmailApp.moveThreadsToArchive(threads);
    archived += threads.length;

    Logger.log(`[${rule.description}] Archived ${threads.length} threads (total: ${archived})`);

    // Small pause to avoid rate limiting
    Utilities.sleep(1000);
  }

  if (archived > 0) {
    Logger.log(`--- ${rule.description}: ${archived} threads archived ---`);
  }

  return archived;
}

// ---------------------------------------------------------------------------
// Reporting
// ---------------------------------------------------------------------------

/**
 * Generate a report of what WOULD be cleaned up (does not archive anything).
 * Run this first to understand the scope.
 */
function generateReport() {
  Logger.log('=== Gmail Cleanup Report ===');
  Logger.log(`Generated: ${new Date().toISOString()}`);
  Logger.log('');

  let grandTotal = 0;

  for (const rule of CONFIG.RULES) {
    // GmailApp.search with a large max to count (capped at 500 by API)
    const threads = GmailApp.search(rule.query, 0, 500);
    const count = threads.length;
    const hasMore = count === 500 ? '+' : '';

    Logger.log(`${rule.description}`);
    Logger.log(`  Query: ${rule.query}`);
    Logger.log(`  Matching threads: ${count}${hasMore}`);

    if (count > 0) {
      // Show a few examples
      const samples = threads.slice(0, 3);
      for (const thread of samples) {
        const msg = thread.getMessages()[0];
        Logger.log(`  Example: "${thread.getFirstMessageSubject()}" from ${msg.getFrom()} (${msg.getDate().toLocaleDateString()})`);
      }
    }

    Logger.log('');
    grandTotal += count;
  }

  Logger.log(`=== Total threads matching cleanup rules: ${grandTotal}+ ===`);
  Logger.log('Run runCleanup() to archive these threads.');
}

// ---------------------------------------------------------------------------
// Sender analysis -- find your top inbox clutterers
// ---------------------------------------------------------------------------

/**
 * Analyze inbox to find which senders have the most emails.
 * Useful for discovering new cleanup rules or filter candidates.
 */
function analyzeSenders() {
  Logger.log('=== Top Inbox Senders Analysis ===');

  const threads = GmailApp.search('in:inbox', 0, 500);
  const senderCounts = {};

  for (const thread of threads) {
    const from = thread.getMessages()[0].getFrom();
    // Normalize: extract email address
    const emailMatch = from.match(/<(.+?)>/);
    const email = emailMatch ? emailMatch[1].toLowerCase() : from.toLowerCase();
    const domain = email.split('@')[1] || email;

    if (!senderCounts[domain]) {
      senderCounts[domain] = { count: 0, example: from };
    }
    senderCounts[domain].count++;
  }

  // Sort by count descending
  const sorted = Object.entries(senderCounts)
    .sort((a, b) => b[1].count - a[1].count)
    .slice(0, 30);

  Logger.log('Top 30 sender domains in inbox:');
  for (const [domain, data] of sorted) {
    Logger.log(`  ${data.count.toString().padStart(4)} emails | ${domain} (e.g., ${data.example})`);
  }
}

// ---------------------------------------------------------------------------
// Setup and teardown
// ---------------------------------------------------------------------------

/**
 * Run once to set up an automatic trigger.
 * The script will run every 30 minutes until the inbox is clean.
 */
function setup() {
  // Remove any existing triggers for this script
  teardown();

  // Create a trigger that runs every 30 minutes
  ScriptApp.newTrigger('runCleanup')
    .timeBased()
    .everyMinutes(30)
    .create();

  Logger.log('Trigger created: runCleanup will run every 30 minutes.');
  Logger.log('Run teardown() when cleanup is complete to remove the trigger.');
}

/**
 * Remove all triggers for this script.
 */
function teardown() {
  const triggers = ScriptApp.getProjectTriggers();
  for (const trigger of triggers) {
    ScriptApp.deleteTrigger(trigger);
  }
  Logger.log(`Removed ${triggers.length} trigger(s).`);
}
