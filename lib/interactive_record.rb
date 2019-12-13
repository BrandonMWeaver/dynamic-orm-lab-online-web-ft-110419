require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name
    return self.to_s.downcase.pluralize
  end
  
  def self.column_names
    sql = "PRAGMA table_info(\"#{table_name}\");"
  end
  
end
