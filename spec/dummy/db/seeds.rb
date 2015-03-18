feature = Feature.create name: "Cadastrar usuário", controller: "curupira/users"

action_1 = ActionLabel.create name: "new"
action_2 = ActionLabel.create name: "create"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Visualizar usuário", controller: "curupira/users"

action_1 = ActionLabel.create name: "index"
action_2 = ActionLabel.create name: "show"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Editar usuário", controller: "curupira/users"

action_1 = ActionLabel.create name: "edit"
action_2 = ActionLabel.create name: "update"

feature.action_labels = [action_1, action_2]

feature = Feature.create name: "Deletar usuário", controller: "curupira/users"

action_1 = ActionLabel.create name: "destroy"

feature.action_labels = [action_1]

feature.save

###############################################

feature = Feature.create name: "Cadastrar Perfis", controller: "curupira/roles"

action_1 = ActionLabel.create name: "new"
action_2 = ActionLabel.create name: "create"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Visualizar Perfis", controller: "curupira/roles"

action_1 = ActionLabel.create name: "index"
action_2 = ActionLabel.create name: "show"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Editar Perfis", controller: "curupira/roles"

action_1 = ActionLabel.create name: "edit"
action_2 = ActionLabel.create name: "update"

feature.action_labels = [action_1, action_2]

feature = Feature.create name: "Deletar Perfis", controller: "curupira/roles"

action_1 = ActionLabel.create name: "destroy"

feature.action_labels = [action_1]

feature.save

###############################################

feature = Feature.create name: "Cadastrar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "new"
action_2 = ActionLabel.create name: "create"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Visualizar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "index"
action_2 = ActionLabel.create name: "show"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Editar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "edit"
action_2 = ActionLabel.create name: "update"

feature.action_labels = [action_1, action_2]

feature = Feature.create name: "Deletar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "destroy"

feature.action_labels = [action_1]

feature.save

###############################################

feature = Feature.create name: "Cadastrar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "new"
action_2 = ActionLabel.create name: "create"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Visualizar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "index"
action_2 = ActionLabel.create name: "show"

feature.action_labels = [action_1, action_2]

feature.save

feature = Feature.create name: "Editar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "edit"
action_2 = ActionLabel.create name: "update"

feature.action_labels = [action_1, action_2]

feature = Feature.create name: "Deletar Grupos", controller: "curupira/groups"

action_1 = ActionLabel.create name: "destroy"

feature.action_labels = [action_1]

feature.save