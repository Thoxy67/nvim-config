return {
  -- Connection settings
  ip = "127.0.0.1",
  user = "your_username",
  -- port = 22,  -- Uncomment and set if using non-standard SSH port
  
  -- Remote path where files will be synced
  location = "/home/your_username/projects",
  
  -- Transfer protocol: "rsync" or "sftp"
  protocol = "rsync",
  
  -- Files and directories to exclude (in addition to .git and .gitignore)
  excludes = {
    "node_modules/",
    "*.log",
    ".env.local",
    "dist/",
    "build/",
    ".DS_Store",
    "*.tmp",
  },
  
  -- Auto-sync settings
  auto_sync = {
    enabled = false,         -- Enable automatic sync on file save
    debounce_ms = 1000,     -- Wait time before syncing after last change
    only_git_files = true,  -- Only sync files tracked by git
  },
  
  -- Notification settings
  notifications = {
    enabled = true,
    show_progress = true,
    timeout = 3000,
  },
  
  -- Advanced rsync options
  rsync_opts = {
    compress_level = 6,     -- Compression level (1-9)
    partial_transfers = true, -- Resume partial transfers
    preserve_permissions = true,
    preserve_times = true,
  },
  
  -- SFTP specific options (when using protocol = "sftp")
  sftp_opts = {
    timeout = 30,           -- Connection timeout in seconds
    max_retries = 3,        -- Maximum connection retries
    auto_confirm = true,    -- Auto-confirm host keys
  },
}
