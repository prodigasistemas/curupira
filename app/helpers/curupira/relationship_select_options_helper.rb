module Curupira::RelationshipSelectOptionsHelper
  def active_user_groups_select_options
    [["Selecione um grupo", nil]] + Group.active.map { |g| [g.name, g.id] }
  end
end
