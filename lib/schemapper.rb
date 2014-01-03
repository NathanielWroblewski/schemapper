require "#{Dir.pwd}/config/environment.rb"

Rails.application.eager_load!
models = ActiveRecord::Base.descendants
tables = models.map(&:table_name)

nodes = tables.map do |table|
  { name: table }
end

all_links = models.each_with_index.flat_map do |model, index|
  associations = model.reflections.map do |reflection|
    target = reflection[1].table_name rescue nil
    if target && tables.index(target)
      { source: index, target: tables.index(target), value: rand(1..5) }
    end
  end
  associations.compact
end
links = all_links.select(&:present?)

attrs = models.map do |model|
  { table: model.table_name, attrs: model.attribute_names }
end

puts YAML.dump({ nodes: nodes, links: links, attributes: attrs.uniq })
