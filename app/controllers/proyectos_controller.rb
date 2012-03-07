class ProyectosController < ApplicationController
  # GET /proyectos
  # GET /proyectos.json
	
	
  def index
    @proyectos = Proyecto.all
		#	@user_agent = request.env['HTTP_USER_AGENT']
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proyectos }
    end
  end

  # GET /proyectos/1
  # GET /proyectos/1.json
  def show
    @proyecto = Proyecto.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/new
  # GET /proyectos/new.json
  def new
    @proyecto = Proyecto.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @proyecto }
    end
  end

  # GET /proyectos/1/edit
  def edit
    @proyecto = Proyecto.find(params[:id])
  end

  # POST /proyectos
  # POST /proyectos.json
  def create
    @proyecto = Proyecto.new(params[:proyecto])

    respond_to do |format|
      if @proyecto.save
        format.html { redirect_to @proyecto, notice: 'Proyecto was successfully created.' }
        format.json { render json: @proyecto, status: :created, location: @proyecto }
      else
        format.html { render action: "new" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /proyectos/1
  # PUT /proyectos/1.json
  def update
    @proyecto = Proyecto.find(params[:id])

    respond_to do |format|
      if @proyecto.update_attributes(params[:proyecto])
        format.html { redirect_to @proyecto, notice: 'Proyecto was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @proyecto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proyectos/1
  # DELETE /proyectos/1.json
  def destroy
    @proyecto = Proyecto.find(params[:id])
    @proyecto.destroy

    respond_to do |format|
      format.html { redirect_to proyectos_url }
      format.json { head :no_content }
    end
  end
	
	def fotos
		@proyecto = Proyecto.find(params[:id], :include => :fotos)
		
		respond_to do |format|
			format.html
			format.json{ head :no_content}
		end
	end
	
	def agregar_foto
		@proyecto = Proyecto.find(params[:id])
		@foto = Foto.new(:proyecto_id => @proyecto.id)
		
		respond_to do ||
				format.html
			format.json{ head :no_content}
		end
	end
	
	def ver_proyecto
		@proyecto = Proyecto.find(params[:id])
		render :layout => 'index'
	end
	
	def download

		proyecto = Proyecto.find(params[:id])
		fotos = Foto.find_all_by_proyecto_id(proyecto.id)
		videos = Video.find_all_by_proyecto_id(proyecto.id)
		discos = Disco.all
		#crear el directorio principal del proyecto y lo necesario
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/javascript"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/css"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/images"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/images/catalogo"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/images/galeria"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/video"
		FileUtils.mkdir "#{Rails.root}/public/downloads/proyecto/audio"
		#copio los archivos necesarios
		FileUtils.copy("#{Rails.root}/app/assets/stylesheets/glisse.css", "#{Rails.root}/public/downloads/proyecto/css/glisse.css")
		FileUtils.copy("#{Rails.root}/app/assets/javascripts/glisse.min.js", "#{Rails.root}/public/downloads/proyecto/javascript/glisse.min.js")
		FileUtils.copy("#{Rails.root}/app/assets/javascripts/audio-player.js", "#{Rails.root}/public/downloads/proyecto/javascript/audio-player.js")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/Mod_background.jpg", "#{Rails.root}/public/downloads/proyecto/images/Mod_background.jpg")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/portada.jpg", "#{Rails.root}/public/downloads/proyecto/images/portada.jpg")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/portada_catalogo.jpg", "#{Rails.root}/public/downloads/proyecto/images/portada_catalogo.jpg")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/portada_contacto.JPG", "#{Rails.root}/public/downloads/proyecto/images/portada_contacto.JPG")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/portada_fotos.JPG", "#{Rails.root}/public/downloads/proyecto/images/portada_fotos.JPG")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/portada_video.jpg", "#{Rails.root}/public/downloads/proyecto/images/portada_videos.jpg")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/favicon.ico", "#{Rails.root}/public/downloads/proyecto/images/favicon.ico")
		FileUtils.copy("#{Rails.root}/app/assets/images/presentacion/LOGO.ico", "#{Rails.root}/public/downloads/proyecto/images/LOGO.ico")
		FileUtils.copy("#{Rails.root}/public/jquery.min.js", "#{Rails.root}/public/downloads/proyecto/javascript/jquery.min.js")
		FileUtils.copy("#{Rails.root}/public/jwplayer.js", "#{Rails.root}/public/downloads/proyecto/javascript/jwplayer.min.js")
		FileUtils.copy("#{Rails.root}/public/player.swf", "#{Rails.root}/public/downloads/proyecto/javascript/player.swf")
		FileUtils.copy("#{Rails.root}/public/audio-player.swf", "#{Rails.root}/public/downloads/proyecto/javascript/audio-player.swf")
		
		discos.each do |disco|
			FileUtils.copy("#{Rails.root}/public/" + disco.imagen_url.to_s, "#{Rails.root}/public/downloads/proyecto/images/catalogo/" + disco.id.to_s + ".jpg")
			FileUtils.copy("#{Rails.root}/public/" + disco.muestra_url.to_s, "#{Rails.root}/public/downloads/proyecto/audio/" + disco.id.to_s + ".mp3")
		end
		
		fotos.each do |foto|
			FileUtils.copy("#{Rails.root}/public/" + foto.imagen_url.to_s, "#{Rails.root}/public/downloads/proyecto/images/galeria/" + foto.id.to_s + ".jpg")
			
			foto_string = "<img src='images/galeria/#{foto.id.to_s}.jpg' height = '200'/>"
		end
		
		videos.each do |video|
			FileUtils.copy("#{Rails.root}/public/" + video.video_url.to_s, "#{Rails.root}/public/downloads/proyecto/video/" + video.id.to_s + ".mp4")
		end

		#creo el index
		File.open("#{Rails.root}/public/downloads/proyecto/index.html", "w") do |f|
			f.puts '<!DOCTYPE html>
			<html>
			<head>
			<title>Presentacion del Disco</title>
			<link rel="shortcut icon" href="images/favicon.ico" />
			<script src="javascript/jquery.min.js"></script>
			<style>

      body{
	/*    background-color:#AFC4BD;*/
	background-image: url(images/Mod_background.jpg);
      }

      #container{
	background-image: url(images/Mod_background.jpg);
	background-repeat: no-repeat;
	background-position: center;

	height: 600px;
      }

      #content{
        text-align: center;
      }
    </style>
	</head>
	<body>
		<div id="container">
<div id="content">
  <img src="images/portada.jpg" usemap = "#links"  class = "imagen"  />
  <map id="links" name="links">
    <area shape="rect" coords="45, 36, 303, 304" href="galeria.html" alt="fotos" onmouseover="cambiarImagen(\'foto\')" onmouseout="volverPortada()"/>
    <area shape="rect" coords="305, 36, 564, 304" href="video.html " alt="video" onmouseover="cambiarImagen(\'video\')" onmouseout="volverPortada()"/>
    <area shape="rect" coords="45, 304, 303, 577" href="catalogo.html" alt="catalogo" onmouseover="cambiarImagen(\'catalogo\')" onmouseout="volverPortada()"/>
    <area shape="rect" coords="305, 304, 564, 577" href="contacto.html" alt="contacto" onmouseover="cambiarImagen(\'contacto\')" onmouseout="volverPortada()"/>
  </map>
</div>
		</div>
<script type="text/javascript">
  function cambiarImagen(imagen){
    if(imagen == "foto"){
      $(".imagen").attr("src","images/portada_fotos.JPG")
    }
    if(imagen == "video"){
      $(".imagen").attr("src","images/portada_videos.jpg" )
    }
    if(imagen == "catalogo"){
      $(".imagen").attr("src","images/portada_catalogo.jpg" )
    }
    if(imagen == "contacto"){
      $(".imagen").attr("src","images/portada_contacto.JPG" )
    }
  }
  
  function volverPortada(){
    $(".imagen").attr("src", "images/portada.jpg" )
  }
</script>
	</body>
	</html>'
		end		
		
		
		#internas
		head  = '<!DOCTYPE html><html><head><title>Presentacion del Disco</title>
						<link rel="shortcut icon" href="images/favicon.ico" />
						<script src="javascript/jquery.min.js"></script>
						<script src="javascript/glisse.min.js"></script>
						<script type="text/javascript" src="javascript/jwplayer.min.js"></script>
						<script type="text/javascript" src="javascript/audio-player.js"></script>
						<link rel="stylesheet" href="css/glisse.css" />
						<style>
							body{	background-image: url(images/Mod_background.jpg); }
							.container{ width: 681px; margin: 26px auto auto; border: 0.5px solid #97A29E; box-shadow: 4px 10px 5px #888; background-color: #FBFBFB; }
							.navbar{ width: 100%; float: left; padding-left: 10px;}
							.navbar ul{ float: right; background-color: #E87765; padding: 3px; padding-left: 10px; margin-right: 20px; }
							.navbar ul li{ list-style: none; float: left; margin-bottom: 5px; margin-right: 25px; 	color: #000000; font-family: Helvetica,serif; font-size: 0.7em; line-height: 1.6em; text-transform: uppercase; }\
							.navbar ul li a{ text-decoration: none; color: #333333; }
							hr{ background-color: #E87765; border-style: hidden; color: #E87765; height: 1px; }
							h3{ color: #A3A39E; font-family: Helvetica,serif; margin-left: 5px; }
							.content p, .content label, .content li, .footer p{ color: #424242; font-family: "Helvetica","Arial",sans-serif; font-size: 12px;}
							.footer p{ padding-left: 5px; }
							.footer p a{ text-decoration: none;}
						</style></head>
						<body><div class="container"><div class="navbar">
							<ul>
								<li><a href="index.html">Inicio</a></li>
								<li><a href="catalogo.html">Cat&aacute;logo</a></li>
								<li><a href="video.html">Video</a></li>
								<li><a href="galeria.html">Galer&iacute;a</a></li>
								<li><a href="contacto.html">Contacto</a></li>
							</ul>
						</div>
      <div class="content">'
		
		foot = '</div></body></html>'
		
		#armar galeria
		foto_string = "<div style='height: 800px;'>
								<div><h3>Galer&iacute;a de Im&aacute;genes</h3><hr /></div>"
		fotos.each do |foto|
			foto_string << '<div style="float: left; margin: 15px;">
										<div style="margin-bottom: 5px;">'
			foto_string << " <img src = 'images/galeria/#{foto.id}.jpg' height='100' class = 'pics'  data-glisse-big = 'images/galeria/#{foto.id}.jpg' rel = 'group' title = '#{foto.descripcion}' "
			foto_string << "</div>
      <div style='text-align: center;'>
			<label>#{foto.descripcion}</label>
      </div>
      </div>
    </div>"
		end
		foto_string << '</div>'
		
		#armar catalogo
		catalogo_string = "
<script type=\"text/javascript\">  
    AudioPlayer.setup(\"javascript/audio-player.swf\", {  
      width: 290  
    });  
  </script>
<div style=\"height: 2700px;\">
									<div><h3>Cat&aacute;logo</h3><hr /></div> "
		
		discos.each do |f|
			catalogo_string << "<div style='float: left; width: 100%; margin-bottom: 20px;'>
											<div style=\"float: left; padding-left: 22px; margin-right: 20px;\">
											<img style = 'height:228px; width:231px' src='images/catalogo/#{f.id}.jpg' />
											</div>"
											
			catalogo_string << "<div>
<p style=\"color:#328CBE; font-size: 18px\">#{f.nombre}</p>
    <ul style=\"list-style: none\">"
			for pista in f.pistas
				catalogo_string << "<li>#{pista.nombre}</li>"
			end
		
			catalogo_string << "</ul>
  

<p id=\"audioplayer_#{f.id}\">Alternative content</p>  
<script type=\"text/javascript\">  
  AudioPlayer.embed(\"audioplayer_#{f.id}\", {soundFile: \"audio/#{f.id}.mp3\"});  
</script>
  </div>
			</div>
			   "
		end
		catalogo_string << '</div>'
 
		#armar video
		video_string = "<div><div><h3>Videos</h3><hr /></div>"
		
		videos.each do |f|
			video_string << "<div style='padding 2px; width: 100%;'>
<div class=\"descripcion\" style=\"margin-left: 10px;\">

      <h4>#{f.nombre} </h4>
      <p>#{f.descripcion}</p>
    </div>
    <div style=\"text-align: center; margin-left: 167px; margin-bottom: 20px;\">
		<div id=\"mediaplayer-#{f.id}\" ></div>

<script type='text/javascript'>
		jwplayer(\"mediaplayer-#{f.id}\").setup({
			flashplayer: 'javascript/player.swf',
			file: 'video/#{f.id}.mp4'
		});
	</script>
    </div>
</div>"
		end
		video_string << '</div>'
		
		contacto_string = "<div style=\"height: 600px;\"><div><h3>Contacto</h3><hr /></div> "
		contacto_string << "<p style='margin-left:10px'>Para contactar con Germ&aacute;n Lema,<a href='mailto:gerlema@gmail.com' style='text-decoration:none'> aqui</a></p>"
		contacto_string << "<p style='margin-left:10px'>Para contactar con Patas Arriba,<a href='mailto:patas.py@gmail.com'  style='text-decoration:none'> aqui</a><p>"
		contacto_string << "</div	>"
		
		
		File.open("#{Rails.root}/public/downloads/proyecto/video.html", "w")	do |f|
			f << head
			f << video_string
			f << foot
		end
		
		
		File.open("#{Rails.root}/public/downloads/proyecto/catalogo.html", "w")	do |f|
			f << head
			f << catalogo_string
			f << foot
		end
		
		
		File.open("#{Rails.root}/public/downloads/proyecto/contacto.html", "w")	do |f|
			f << head
			f << contacto_string
			f << foot
		end
		
		
		File.open("#{Rails.root}/public/downloads/proyecto/galeria.html", "w") do |f|
			f << head
			f << foto_string
			
			f << "<script type=\"text/javascript\">
  $(function(){
    $('.pics').glisse(
    {
      changeSpeed: 550,
      speed: 500,
      effect: 'bounce'
    })
  })
</script>

<style>
  #glisse-controls {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    height: 40px;
    font-size: 13px;
    font-weight: bold;
    color: #fff;
    border-top: 1px solid #2d2f35;
    text-shadow: 0 -1px 0 #333333;
    background-image: -webkit-gradient(linear, 50% 0%, 50% 100%, color-stop(0%, rgba(87, 90, 98, 0.9)), color-stop(100%, rgba(62, 65, 72, 0.9)));
    background-image: -webkit-linear-gradient(rgba(87, 90, 98, 0.9), rgba(62, 65, 72, 0.9));
    background-image: -moz-linear-gradient(rgba(87, 90, 98, 0.9), rgba(62, 65, 72, 0.9));
    background-image: -o-linear-gradient(rgba(87, 90, 98, 0.9), rgba(62, 65, 72, 0.9));
    background-image: -ms-linear-gradient(rgba(87, 90, 98, 0.9), rgba(62, 65, 72, 0.9));
    background-image: linear-gradient(rgba(87, 90, 98, 0.9), rgba(62, 65, 72, 0.9));
    -moz-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15), 0 1px 3px rgba(0, 0, 0, 0.7);
    -webkit-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15), 0 1px 3px rgba(0, 0, 0, 0.7);
    -o-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15), 0 1px 3px rgba(0, 0, 0, 0.7);
    box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15), 0 1px 3px rgba(0, 0, 0, 0.7); }

  .glisse-next a, .glisse-prev a {
    position: absolute;
    display: block;
    left: 0;
    height: 39px;
    width: 39px;
    font-family: 'WebSymbolsRegular';
    line-height: 40px;
    color: white;
    font-size: 16px;
    text-align: center;
    text-decoration: none;
    text-shadow: 0 -1px 0 black; }

  .glisse-next a:active, .glisse-prev a:active {
    text-shadow: 0 0 30px white, 0 0 10px white; }

  .glisse-prev a {
    border-right: 1px solid #2d2f35;
    -moz-box-shadow: inset -1px 0 0 rgba(255, 255, 255, 0.15);
    -webkit-box-shadow: inset -1px 0 0 rgba(255, 255, 255, 0.15);
    -o-box-shadow: inset -1px 0 0 rgba(255, 255, 255, 0.15);
    box-shadow: inset -1px 0 0 rgba(255, 255, 255, 0.15); }

  .glisse-next a {
    left: auto;
    right: 0;
    border-left: 1px solid #2d2f35;
    -moz-box-shadow: inset 1px 0 0 rgba(255, 255, 255, 0.15);
    -webkit-box-shadow: inset 1px 0 0 rgba(255, 255, 255, 0.15);
    -o-box-shadow: inset 1px 0 0 rgba(255, 255, 255, 0.15);
    box-shadow: inset 1px 0 0 rgba(255, 255, 255, 0.15); }

  .glisse-legend {
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    position: absolute;
    top: 0;
    bottom: 0;
    left: 40px;
    right: 40px;
    text-align: center;
    line-height: 40px; }
</style>"
			f << foot
		end
		
		#crear el zip
		#    Zip::ZipFile.open("#{Rails.root}/public/download/prueba.zip", Zip::ZipFile::CREATE)do |zipfile|
		#      Find.find(dir) do |path|
		#        Find.prune if File.basename(path)[0] == ?.
		#        dest = /#{dir}\/(\w.*)/.match(path)
		#        # Skip files if they exists
		#        begin
		#          zipfile.add(dest[1],path) if dest
		#        rescue Zip::ZipEntryExistsError
		#        end
		#      end
		#    end
		#    
		path_o = "#{Rails.root}/public/downloads"
		path = "#{path_o}/proyecto"
		path.sub!(%r[/$],'')
		archive = File.join(path_o,File.basename(path))+'.zip'
		FileUtils.rm archive, :force=>true
		level = Zlib::BEST_COMPRESSION
		Zip::ZipFile.open(archive, 'w') do |zip|
			Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
				zip.add(file.sub(path+'/',''),file)
			end
		end
		
		#descargo el archivo
		send_file "#{path_o}/proyecto.zip", :type=>"application/zip"
		
		FileUtils.rm_rf path
		File.delete("#{path_o}/proyecto.zip")
  end
end
