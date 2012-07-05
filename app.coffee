express = require 'express'
assets  = require 'connect-assets'
md      = require('node-markdown').Markdown
fs      = require 'fs'
app     = express.createServer express.logger()

app.use assets buildDir: "builtAssets"
app.use express.static "#{__dirname}/public"
app.set 'view engine', 'jade'

empDesc = (name) -> 
  md fs.readFileSync './employerDescriptions/'+name+'.md', 'utf8', (err,data) -> data


employers = [
    {
      'timeline': 'February 2012 - April 2012',
      'company': 'Uberlife',
      'url': 'http://uberlife.com',
      'role': 'Developer',
      'description': empDesc 'uberlife'
    },
    {
      'timeline': 'July 2010 - February 2012',
      'company': 'AOL',
      'url': 'http://corp.aol.com',
      'role': 'Software Engineer',
      'description': empDesc 'aol'
    },
    {
      'timeline': 'May 2008 - July 2010',
      'company': 'New Bamboo',
      'url': 'http://new-bamboo.co.uk',
      'role': 'Developer',
      'description': empDesc 'new-bamboo'
    },
    {
      'timeline'    : 'February 2008 - May 2008',
      'company'     : 'Naked',
      'url'         : 'http://getnaked.com',
      'role'        : 'Developer', 
      'description' : empDesc 'naked'
    },
    {
      'timeline'    : 'June 2007 - December 2007',
      'company'     : 'Tickex',
      'url'         : 'http://tickex.com',
      'role'        : 'Developer',
      'description' : empDesc 'tickex'
    },
    {
      'timeline'    : 'October 2006 - December 2006', 
      'company'     : 'TopDrawMedia', 
      'url'         : 'http://topdrawmedia.com',
      'role'        : 'Web Developer', 
      'description' : empDesc 'topdrawmedia'
    },
    {
      'timeline':   'June - August 2004', 
      'company':    'AmTrac Ltd', 
      'url':        '#',
      'role':       'Cladding Labourer', 
      'description': empDesc  'amtrac' 
    }
  ]

  achievements = [
    {'year': 2002, 'achievement': 'Awarded certificate for outstanding achievement in Business Education'},
    {'year': 2002, 'achievement': 'Awarded credit for Young Enterprise Examination'},
    {'year': 2003, 'achievement': 'Awarded certificate for outstanding achievement in Academic Excellence'},
    {'year': 2003, 'achievement': 'Awarded curriculum award for Information Technology'},
    {'year': 2004, 'achievement': 'Awarded curriculum award for Communication Studies (100% score in both A2 exams)'},
    {'year': 2004, 'achievement': 'Awarded certificate for outstanding achievement in 6th form community involvement'},
    {'year': 2005, 'achievement': 'Competed in the final of the IBM University business challenge 2004/2005, came 4th place out of 136 teams who competed.'}
  ]


# For some reason, express 3.0 beta does not have a 'layout' and 'index' concept like before
app.get '/', (req, res) ->
  res.render 'index'

app.get '/cv', (req, res) ->
  res.render 'cv', {employers, achievements} 

app.listen 3000