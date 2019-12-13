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
    
    return column_names.compact
  end
  
  def initialize(options={})
    options.each do |key, value|
      self.send("#{key}=", value)
    end
  end
  
  def table_name_for_insert
    return self.class.table_name
  end
  
  def col_names_for_insert
    return self.class.column_names.delete_if { |col| col == "id" }.join(", ")
  end
  
  def values_for_insert
    values = []
    self.class.column_names.each do |column_name|
      values << "'#{send(column_name)}'" unless send(column_name).nil?
    end
    
    return values.join(", ")
  end
  
  def save
    
  end
  
end
