class RemoveLogidzeFunctions < ActiveRecord::Migration[7.1]
  def change
    execute <<~SQL
      DROP FUNCTION IF EXISTS logidze_capture_exception(jsonb) CASCADE;
      DROP FUNCTION IF EXISTS logidze_compact_history(jsonb, integer) CASCADE;
      DROP FUNCTION IF EXISTS logidze_filter_keys(jsonb, text[], boolean) CASCADE;
      DROP FUNCTION IF EXISTS logidze_logger() CASCADE;
      DROP FUNCTION IF EXISTS logidze_logger_after() CASCADE;
      DROP FUNCTION IF EXISTS logidze_snapshot(jsonb, text, text[], boolean) CASCADE;
      DROP FUNCTION IF EXISTS logidze_version(bigint, jsonb, timestamp with time zone) CASCADE;
    SQL
  end
end