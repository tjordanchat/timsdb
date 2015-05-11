#!/usr/bin/ruby

require 'rubygems'
require 'webrick'
require 'json'
require 'yaml'

server = WEBrick::HTTPServer.new(:Port => 5050)
server.mount_proc '/' do |req, res|
  puts req.body
  p = JSON.parse(req.body)
  ref = p["ref"]
  if /^refs\/tags\/RC_/ =~ ref
    url = p["repository"]["url"]
    uid = p["user_id"]
    pid = p["project_id"]
    command="gitlab user get --id=%s -v | shyaml get-value email" % uid
    email = `#{command}`
    bname = ref.split('/')[2]
    c1 = "gitlab project-branch create --project-id=%s --branch-name=%s --ref=refs/heads/develop" % [ pid, bname ]
    c2 = "gitlab project-branch protect --id=%s --project-id=%s" % [ bname , pid ]
    `#{c1}`
    `#{c2}`
     c3 = "gitlab project-branch get --project-id=%s --id=%s -v | shyaml get-value protected" % [ pid, bname ]
     proj_name = "gitlab project get --id=%s -v | shyaml get-value name-with-namespace" % pid 
     protect = `#{c3}`
     body = "mail %s <<EOF
     A new branch '%s' was created for project %s
     with protection status = %s
     EOF" % [ email, bname, proj_name, protect ]
     `#{body}`
  end
end

trap 'INT' do 
  server.shutdown 
end
server.start
