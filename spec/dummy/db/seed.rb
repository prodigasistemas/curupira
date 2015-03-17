users_service = Service.create(name: "curupira/users")

feature_read = Feature.create name: "Ler"
feature_write = Feature.create name: "Escrever"

index_action = ActionLabel.create name: "index", feature: feature_read
show_action = ActionLabel.create name: "show", feature: feature_read

index_action = ActionLabel.create name: "index", feature: feature_write
show_action = ActionLabel.create name: "show", feature: feature_write
edit_action = ActionLabel.create name: "edit", feature: feature_write
new_action = ActionLabel.create name: "new", feature: feature_write
create_action = ActionLabel.create name: "create", feature: feature_write
update_action = ActionLabel.create name: "update", feature: feature_write

read_users = FeatureService.create(service: users_service, feature: feature_read)   ### 
write_users = FeatureService.create(service: users_service, feature: feature_write) ### 