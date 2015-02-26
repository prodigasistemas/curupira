class AddCurupiraToUsers < ActiveRecord::Migration
  def self.up
    change_table :users  do |t|
<% @user_columns.values.each do |column| -%>
      <%= column %>
<% end -%>
    end
<% @user_indexes.values.each do |index| -%>
    <%= index %>
<% end -%>
  end

  def self.down
    change_table :users do |t|
<% if @user_columns.any? -%>
      t.remove <%= @user_columns.keys.map { |column| ":#{column}" }.join(",") %>
<% end -%>
    end
  end
end