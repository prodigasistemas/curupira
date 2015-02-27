shared_examples "valid role model" do
  it "generate role model" do
    run_generator
    role_class = file("app/models/role.rb")
    
    expect(role_class).to exist
    expect(role_class).to have_correct_syntax
    expect(role_class).to contain("validates_presence_of :name")
    expect(role_class).to contain("has_many :authorizations")
    expect(role_class).to contain("has_many :features, through: :authorizations")
    expect(role_class).to contain("accepts_nested_attributes_for :authorizations, reject_if: :all_blank, allow_destroy: :true")
  end
end