class Curupira::FeaturesController < Curupira::AuthorizedController
	def index
		@features = Feature.all
	end

	def new
		@feature = Feature.new
	end

	def show
		@feature = Feature.find(params[:id])
	end

	def create
		@feature = Feature.new feature_params

		if @feature.save 
			redirect_to @feature, notice: "Nova Caracteristica cadastrada" 
		else
			render :new
		end
	end

	def edit
		@feature = Feature.find(params[:id])
	end

	def update
    @feature = Feature.find(params[:id])

  	if @feature.update feature_params
    		redirect_to @feature, notice: "Caracteristica atualizada com sucesso"
  	else
    		render :edit
  	end
	end

	private
  
	def feature_params
		params.require(:feature).permit(:name, :active)
	end
end