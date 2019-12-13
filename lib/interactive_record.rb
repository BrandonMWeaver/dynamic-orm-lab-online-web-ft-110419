require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    return self.to_s.downcase.pluralize
  end
  
  def self.column_names
    sql = "PRAGMA table_info(\"#{table_name}\");"
    table_info = DB[:conn].execute(sql)
    
    column_names = []
    table_info.each do |column|
      column_names << column["name"]
    end
    
    column_names.compact
  end
  
  def self.attr_accessor
    column_names.each do |column_name|
      attr_accessor column_name.to_sym
    end
  end
  
  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
end
