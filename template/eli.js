var type="${ELI_TYPE}",user="${ELI_USER}",max=${ELI_MAX},tag="elitimeline",api="${ELI_API}",user_api="users/show/",user_rss="statuses/user_timeline/",group_api="statusnet/groups/show/",group_rss="statusnet/groups/timeline/",api_url=api+user_api,api_rss_url=api+user_rss,img_name="profile_image_url";"group"==type&&(api_url=api+group_api,api_rss_url=api+group_rss,img_name="stream_logo");url=api_url+user+".xml"; function displayResult(){xmlhttp=window.XMLHttpRequest?new XMLHttpRequest:new ActiveXObject("Microsoft.XMLHTTP");xmlhttp.open("GET",url,!1);xmlhttp.send();xmlDoc=xmlhttp.responseXML;userinfo=xmlDoc.getElementsByTagName(type);try{id=userinfo[0].getElementsByTagName("id")[0].childNodes[0].nodeValue}catch(e){id=e}try{img=userinfo[0].getElementsByTagName(img_name)[0].childNodes[0].nodeValue}catch(f){img=""}rss_url=api_rss_url+id+".xml";xmlhttp.open("GET",rss_url,!1);xmlhttp.send();xmlDoc=xmlhttp.responseXML; content='<div id="eli_widget"><header>';""!=img&&(content+='<img src="'+img+'" alt="'+user+'" title="Avatar"/>');content+=" <p>"+user+"</p></header>";for(var b=xmlDoc.getElementsByTagName("statuses").item(0).getElementsByTagName("status"),c=max-1,a=0;a<b.length;a++){try{var d=b[a].getElementsByTagName("statusnet:html").item(0).firstChild.data}catch(g){d=""}content+="<article>"+d+"</article>";c<b.length&&a==c&&(a=b.length)}content+="<footer></footer></div>";document.getElementById(tag).innerHTML=content};window.onload=displayResult ;
