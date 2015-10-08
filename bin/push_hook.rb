#!/usr/bin/ruby

require 'rubygems'
require 'webrick'
require 'json'
require 'yaml'

server = WEBrick::HTTPServer.new(:Port => 6060)
server.mount_proc '/' do |req, res|
  puts req.body
  p = JSON.parse(req.body)
  if p["ref"] == "refs/heads/develop"
    remote = p["repository"]["url"]
    email = p["commits"][0]["author"]["email"]
    url = p["repository"]["url"]
    after = p["after"]
    pat = /[^:]*:(.*)\.git/
    job = pat.match(url)[1]
    command="git archive --remote=ssh://%s develop build.yml | tar xvf -" % remote.gsub(":","/")
    puts `#{command}`
    cfg = YAML.load_file('build.yml')
    if cfg.length > 0
      env = cfg['env']
      command = "java -jar /home/JJordan/jenkins-cli.jar -i /home/JJordan/.ssh/id_rsa build %s -p env=%s -p url=%s -p email=%s -p commit=%s" % [job,env, url,email,after]
      ENV['JENKINS_URL']="http://198.162.0.1:8080"
      puts command
      puts `#{command}`
    end
  end
end

trap 'INT' do 
  server.shutdown 
end
server.start
