namespace :db do
  desc "Dumps the database to db/APP_NAME.dump"
  task :dump => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_dump --verbose --clean --no-owner --no-acl --format=c #{db} > #{Rails.root}/db/backups/#{app}#{DateTime.now.strftime("%d:%H:%M:%m:%Y")}.psql"
      

    end
    puts cmd
    exec cmd

  end

  desc "Restores the database dump at db/APP_NAME.dump."
  task :restore => :environment do
    cmd = nil
    with_config do |app, host, db, user|
      cmd = "pg_restore --verbose   --clean --no-owner --no-acl --dbname #{db} #{Rails.root}/db/backups/#{app}.dump"
    end
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    puts cmd
    exec cmd

  end

  desc "Upload latest database backup to S3"
  task :upload_aws => :environment do
    cmd = nil
      with_config do |app, host, db, user|
      latest_backup  = "#{Rails.root}/db/backups/#{app}#{DateTime.now.strftime("%d:%H:%M:%m:%Y")}.psql"
      cmd = "s3cmd put #{latest_backup} s3://ninetyfivebooks-assets"
      end
    puts cmd
    exec cmd 
  end

  desc "Dump latest database and upload to AWS"
  task :dump_and_upload => [:dump, :upload_aws]  do
  end





  private

  def with_config
    yield Rails.application.class.parent_name.underscore,
      ActiveRecord::Base.connection_config[:host],
      ActiveRecord::Base.connection_config[:database],
      ActiveRecord::Base.connection_config[:username]
  end

end