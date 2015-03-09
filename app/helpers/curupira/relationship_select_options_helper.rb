module Curupira::RelationshipSelectOptionsHelper
  def active_user_groups_select_options
    [["Selecione um grupo", nil]] + Group.active.map { |g| [g.name, g.id] }
  end

  def active_features_select_options
    [["Selecione uma funcionalidade", nil]] + Feature.all.map { |f| [f.description, f.id] }
  end

  def active_roles_select_options
    [["Selecione um perfil", nil]] + Role.all.map { |r| [r.name, r.id] }
  end

  def group_roles_select_options
    [["Selecione um perfil", nil]] + Role.all.map { |r| [r.name, r.id] }
  end
end
