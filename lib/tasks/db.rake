namespace :db do
  desc "Resets the database and loads it from db/dev_seeds.rb"
  task :dev_seed, [:tenant] => [:environment] do |_, args|
    I18n.enforce_available_locales = false
    Tenant.switch(args[:tenant]) { load(Rails.root.join("db", "dev_seeds.rb")) }
  end

  desc "Calculates the TSV column for all comments and proposal notifications"
  task calculate_tsv: :environment do
    logger = ApplicationLogger.new

    logger.info "Calculating tsvector for comments"
    Comment.with_hidden.find_each(&:calculate_tsvector)

    logger.info "Calculating tsvector for proposal notifications"
    ProposalNotification.with_hidden.find_each(&:calculate_tsvector)
  end

  desc "Adds shared extensions to the schema search path in the database.yml file"
  task add_schema_search_path: :environment do
    logger = ApplicationLogger.new
    logger.info "Adding search path to config/database.yml"

    config = Rails.application.config.paths["config/database"].first
    lines = File.readlines(config)
    changes_done = false

    adapter_indices = lines.map.with_index do |line, index|
      index if line.start_with?("  adapter: postgresql")
    end.compact

    adapter_indices.reverse_each do |index|
      unless lines[index + 1]&.match?("schema_search_path")
        lines.insert(index + 1, "  schema_search_path: \"public,shared_extensions\"\n")
        changes_done = true
      end
    end

    if changes_done
      File.write(config, lines.join)
      logger.warn "The database search path has been updated. Restart the application to apply the changes."
    end
  end

  desc "Resets the database and loads it from db/demo_seeds.rb"
  task :demo_seed, [:print_log] => [:truncate_all] do |t, args|
    @avoid_log = args[:print_log] == "avoid_log"
    load Rails.root.join("db", "demo_seeds.rb")
  end

  # TODO: replace with db:truncate_all when upgrading to Rails 6
  desc "Removes all data from all tables and resets sequences"
  task truncate_all: :environment do
    internal_tables = [
      ActiveRecord::Base.internal_metadata_table_name,
      ActiveRecord::Base.schema_migrations_table_name
    ]
    tables = ActiveRecord::Base.connection.tables - internal_tables

    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{tables.join(", ")} RESTART IDENTITY")
  end
end
