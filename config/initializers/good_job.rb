Rails.application.configure do
  config.good_job = {
    preserve_job_records: true,
    retry_on_unhandled_error: false,
    execution_mode: :async,
    queues: '*',
    max_threads: 5,
    poll_interval: 30,
    shutdown_timeout: 25,
    enable_cron: true,
    cron: {
      master: {
        cron: '5 0 */1 */1 *',
        class: 'MasterJob',
        description: 'Daily jobs launcher'
      },
    },
    dashboard_default_locale: :en,
  }
end