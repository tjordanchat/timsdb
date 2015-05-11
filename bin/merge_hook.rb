#!/usr/bin/ruby

require 'rubygems'
require 'webrick'
require 'json'
require 'yaml'

server = WEBrick::HTTPServer.new(:Port => 4040)
server.mount_proc '/' do |req, res|
  puts req.body
  p = JSON.parse(req.body)
  puts p
  target_branch = p["object_attributes"]["target_branch"]
  if target_branch <=> "master"
    source_branch = p["object_attributes"]["source_branch"]
    if /^RC_/ =~ source_branch
      state = p["object_attributes"]["state"]
      uid = p["object_attributes"]["author_id"]
      pid = p["object_attributes"]["target_project_id"]
      mid = p["object_attributes"]["id"]
      command="gitlab user get --id=%s -v | shyaml get-value email" % uid
      email = `#{command}`
      cmd = "curl -X PUT http://scm.jblab.net/api/v3/projects/%s/merge_request/%s/merge?private_token=xyWFSCLUfPyVmUvkrZHm" % [pid, mid]
      result=`#{cmd}`
      puts result
      body = "mail %s <<EOF
      A merge was performed on branch 'master' from '%s'
      %s
EOF" % [ email, source_branch, result ]
      puts body
      `#{body}`
    end
  end
end

trap 'INT' do 
  server.shutdown 
end
server.start
