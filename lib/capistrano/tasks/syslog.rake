namespace :syslog do

  # @return [String]
  def masked_repo_url
    repo_url = fetch(:repo_url)
    if repo_url.match(/\Ahttps/)

      uri = URI.parse(repo_url)
      if uri.password
        uri.password = '***'
      end

      # user is also masked!
      # e.g. https://password:x-oauth-basic@github.com/example/example.git'
      if uri.user
        uri.user = '***'
      end
      uri
    else
      repo_url
    end
  end

  set :tag, 'capistrano'

  set :starting_format,  -> {
    "deploy starting repository:%s revision:%s" % [
      masked_repo_url,
      fetch(:current_revision),
    ]
  }

  set :finishing_format, -> {
    repo_url = fetch(:repo_url)
    "deploy finishing repository:%s revision:%s" % [
      masked_repo_url,
      fetch(:current_revision),
    ]
  }

  desc 'syslog current revision after deploy:starting ( `deploy:set_current_revision` is actual )'
  task :deploy_starting do
    on release_roles(:all) do
      execute "logger -i -s -t %s %s" % [
        fetch(:tag),
        fetch(:starting_format),
      ]
    end
  end

  desc 'syslog current revision after deploy:finishing'
  task :deploy_finishing do
    on release_roles(:all) do
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
