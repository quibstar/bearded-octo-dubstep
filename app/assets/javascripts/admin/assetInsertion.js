jQuery(document).ready(function() {
    var domain = document.domain;
    var port = ":" + window.location.port;
    // if working locally add port
    if(port != undefined) {
      domain = domain + port;
    }

    var ed = "textareaTinyMce";

    $('.featured-image-controls a').live('click',function(){
      var caption = $(this).closest('.featured-image-controls').find("input[name='caption']").is(':checked') ? 1 : 0;
      var description = $(this).closest('.featured-image-controls').find("input[name='description']").is(':checked') ? 1 : 0;
      var zoom = $(this).closest('.featured-image-controls').find("input[name='zoom']").is(':checked') ? 1 : 0;
      var zoomable = '';
      var captionContent = '';
      var cap = '';
      var descriptionContent = '';
      var desc = '';


      var img = $(this).data('image');
      var imgOriginal = $(this).data('original');

      var size = $(this).data('size');
     captionContent = $(this).data('caption');
     descriptionContent = $(this).data('description');

      console.log(ed);

      var imageFloat = $("input[name=float]:checked").val();

      if (imageFloat == undefined) {
        imageFloat = '';
      };

      if (caption == 1) {
        cap = "<span class='caption'>" + captionContent + "</span>";
      }

      if (description == 1) {
        desc = "<span class='description'>" + descriptionContent + "</span>";
      }
      if(zoom == 1) {
        var image = "<a class='asset-image  fbox-asset " + imageFloat + ' ' + size + "' href='http://" + domain  + imgOriginal + "' title='" + captionContent + "' ><img  alt='" + img + "' src='http://" + domain  + img + "'> " + cap + desc + "</a>";
      } else {
        var image = "<span class='asset-image " + imageFloat + ' ' + size + "'><img  alt='" + img + "' src='http://" + domain  + img + "'> " + cap + desc + "</span>";
      }
      
      
      tinyMCE.execCommand("mceInsertRawHTML",false,image);
    });

    $('.doc td a').live('click',function(e){
      e.preventDefault();
      var doc = $(this).data('document');
      var title = $(this).attr('title');
      var type = doc.split('.').pop();
      var docu = "<a class='file " + type + "'href='http://" + domain  + doc + "'target='_blank'>" + tinyMCE.activeEditor.selection.getContent() + "</a>";
      //<a href="/uploads/assets/documents/Designing_for_the_Web.pdf"  target="_blank">Download</a>
      tinyMCE.execCommand("mceInsertRawHTML",false,docu);
    });

    $('.aud td a').live('click',function(e){
      e.preventDefault();
      var aud = $(this).data('audio');
      var playerId = $(this).data('playerid');
      var audio = "<audio id='player" + playerId + "' src='http://" + domain  + aud + "' controls='controls'></audio>";
      console.log(audio);
      //<audio id="player2" src="../media/AirReview-Landmarks-02-ChasingCorporate.mp3" type="audio/mp3" controls="controls">    </audio>
      tinyMCE.execCommand("mceInsertRawHTML",false,audio);

    });

    $('.vid td a').live('click',function(e){
      e.preventDefault();
      var vidData = $(this).data('video');
      // var vid = "<iframe width='560' height='315' src='http://www.youtube.com/embed/" + vidData +"'frameborder='0' allowfullscreen></iframe>"
      var vid = "<a href='http://www.youtube.com/embed/" + vidData + "' class='fbox-asset fancybox.iframe'><img alt='1' src='http://i3.ytimg.com/vi/" + vidData + "/1.jpg?'></a>"
      tinyMCE.execCommand("mceInsertRawHTML",false,vid);

    });

    $('.ext-link td a').live('click',function(e){
      e.preventDefault();
      var link = $(this).data('link');
      var title = $(this).attr('title');
      var target = $(this).attr('target');
      var newLink = "<a class='int-link' href='" + link + "' target='" + target + "'>" + tinyMCE.activeEditor.selection.getContent() + "</a>";
      tinyMCE.execCommand("mceInsertRawHTML",false,newLink);
    });

    $('.int-link td a').live('click',function(e){
      e.preventDefault();
      var link = $(this).data('link');
      var title = $(this).attr('title');
      var newLink = "<a class='int-link' href='http://" + domain + '/' +link + "' target='_blank'>" + tinyMCE.activeEditor.selection.getContent() + "</a>";
      tinyMCE.execCommand("mceInsertRawHTML",false,newLink);
    });

  });