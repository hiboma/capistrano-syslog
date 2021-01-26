namespace :syslog do

  set :tag, 'capistrano'

  set :starting_format,  -> {
    "deploy starting revision:%s" % fetch(:current_revision)
  }

  set :finishing_format, -> {
    "deploy finishing revision:%s" % fetch(:current_revision)
  }

  desc 'syslog current revision after deploy:starting ( `deploy:set_current_revision` is actual )'
  task :deploy_starting do
    on roles(:all) do
      execute "logger -i -s -t %s %s" % [
        fetch(:tag),
        fetch(:starting_format),
      ]
    end
  end

  desc 'syslog current revision after deploy:finishing'
  task :deploy_finishing do
    on roles(:all) do
      execute "logger -i -s -t %s %s" % [
        fetch(:tag),
        fetch(:finishing_format),
      ]
    end
  end

  # Why use deploy:set_current_revision? -> to retrive currrent_revision
  after 'deploy:set_current_revision', 'syslog:deploy_starting'
  after 'deploy:finishing',            'syslog:deploy_finishing'
end
