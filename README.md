# Schemapper

Schemapper is a database-agnostic tool to visualize [Rails](http://rubyonrails.org/) 3.0+ schemas using [D3](http://d3js.org/).
Schemapper does this by walking your models directly to obtain their associations, table names, and attributes.

## Screen Shot
![Screen Shot](https://raw.github.com/NathanielWroblewski/schemapper/master/screen_shot.png)

## Installation

No need to add schemapper to your Gemfile.  Instead, just install it:

    $ gem install schemapper

## Usage

After installing it, just run the following command from the root of your Rails app:

    $ schemapper
    
## Explanation of Code

The code for schemapper is relatively concise, so I'll try to explain it here, which may help you debug any problems that arise.

Calling `$ schemapper` kicks off [this file](https://github.com/NathanielWroblewski/schemapper/blob/master/bin/schemapper).  Let's walk through it.

The script starts up in ruby, and requires some basic serialization libraries for slurping strings from STDOUT and reconstituting them into objects.  Note that paths in this file typically reference paths within the folder structure of this gem.  The first real line of code is:

```
serialized_schema = `ruby #{File.dirname(__FILE__)}/../lib/schemapper.rb`
```

This executes [this file](https://github.com/NathanielWroblewski/schemapper/blob/master/lib/schemapper.rb), and sets the output as a variable called `serialized_schema`.  Let's checkout that file.

The first line of this file requires your project's Rails environment.

```
require "#{Dir.pwd}/config/environment.rb"
```

Note that unlike the previous file, paths in this file are typically referencing files from the directory you executed `$ schemapper` within (hopefully the root of your rails app).  With this line of code, we now have access to your application.

```
Rails.application.eager_load! # loads all the models, etc
models = ActiveRecord::Base.descendants # returns an array of all your models
tables = models.map(&:table_name) # returns an array of the table names of your models
```

By using `ActiveRecord` here, we become database agnostic, and I get away from the need to parse some schema/structure file.

The rest of this file just shapes the data into something that's readily consumable for a d3 force graph.  The return of this file, will be set to the `serialized_schema` variable of our previous file.  That return value is just a YAML-serialized ruby hash.

Back to the original file [here](https://github.com/NathanielWroblewski/schemapper/blob/master/bin/schemapper).  The very next line just turns our YAML-serialized string back into a ruby hash.

```
schema = YAML.load(serialized_schema)
```

The rest of this code, which isn't much, just opens an HTML file that lives in the gem [here](https://github.com/NathanielWroblewski/schemapper/blob/master/lib/schemapper/schemapper.html).  That HTML file loads a minified d3, and defines a few global functions in javascript, namely `visualizeSchema()` which constructs a d3 force graph out of the data placed into the `window._schemapper` variable.  So the following code in our file, just injects our schema into that variable and calls render:

```
html_path = File.expand_path('../../lib/schemapper/schemapper.html', __FILE__) # path to HTML file
d3_path = File.expand_path('../../lib/schemapper/d3.v3.min.js', __FILE__) # path to d3
html_source = File.read(html_path) + '<script>' + File.read(d3_path) + # injects d3 into the HTML file 
  "window._schemapper=#{schema.to_json};visualizeSchema()</script>" # sets the var to our schema hash and renders the graph
```

Then the remaining code simply creates a temporary file, writes the HTML to it, and opens it in your browser.

```
temp_html = '/tmp/schemapper.html'
File.open(temp_html, 'w'){ |file| file.write(html_source) }
`open #{temp_html}`
```

Hope that helps!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
