/** This is the main jskomment script
/*
    http://www.JSON.org/json2.js
    2011-02-23

    Public Domain.

    NO WARRANTY EXPRESSED OR IMPLIED. USE AT YOUR OWN RISK.

    See http://www.JSON.org/js.html


    This code should be minified before deployment.
    See http://javascript.crockford.com/jsmin.html

    USE YOUR OWN COPY. IT IS EXTREMELY UNWISE TO LOAD CODE FROM SERVERS YOU DO
    NOT CONTROL.

    This is a reference implementation. You are free to copy, modify, or
    redistribute.
*/

/*jslint evil: true, strict: false, regexp: false */

/*members "", "\b", "\t", "\n", "\f", "\r", "\"", JSON, "\\", apply,
    call, charCodeAt, getUTCDate, getUTCFullYear, getUTCHours,
    getUTCMinutes, getUTCMonth, getUTCSeconds, hasOwnProperty, join,
    lastIndex, length, parse, prototype, push, replace, slice, stringify,
    test, toJSON, toString, valueOf
*/


// Create a JSON object only if one does not already exist. We create the
// methods in a closure to avoid creating global variables.

var JSON;
if (!JSON) {
    JSON = {};
}

(function () {
    "use strict";

    function f(n) {
        // Format integers to have at least two digits.
        return n < 10 ? '0' + n : n;
    }

    if (typeof Date.prototype.toJSON !== 'function') {

        Date.prototype.toJSON = function (key) {

            return isFinite(this.valueOf()) ?
                this.getUTCFullYear()     + '-' +
                f(this.getUTCMonth() + 1) + '-' +
                f(this.getUTCDate())      + 'T' +
                f(this.getUTCHours())     + ':' +
                f(this.getUTCMinutes())   + ':' +
                f(this.getUTCSeconds())   + 'Z' : null;
        };

        String.prototype.toJSON      =
            Number.prototype.toJSON  =
            Boolean.prototype.toJSON = function (key) {
                return this.valueOf();
            };
    }

    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,
        gap,
        indent,
        meta = {    // table of character substitutions
            '\b': '\\b',
            '\t': '\\t',
            '\n': '\\n',
            '\f': '\\f',
            '\r': '\\r',
            '"' : '\\"',
            '\\': '\\\\'
        },
        rep;


    function quote(string) {

// If the string contains no control characters, no quote characters, and no
// backslash characters, then we can safely slap some quotes around it.
// Otherwise we must also replace the offending characters with safe escape
// sequences.

        escapable.lastIndex = 0;
        return escapable.test(string) ? '"' + string.replace(escapable, function (a) {
            var c = meta[a];
            return typeof c === 'string' ? c :
                '\\u' + ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' : '"' + string + '"';
    }


    function str(key, holder) {

// Produce a string from holder[key].

        var i,          // The loop counter.
            k,          // The member key.
            v,          // The member value.
            length,
            mind = gap,
            partial,
            value = holder[key];

// If the value has a toJSON method, call it to obtain a replacement value.

        if (value && typeof value === 'object' &&
                typeof value.toJSON === 'function') {
            value = value.toJSON(key);
        }

// If we were called with a replacer function, then call the replacer to
// obtain a replacement value.

        if (typeof rep === 'function') {
            value = rep.call(holder, key, value);
        }

// What happens next depends on the value's type.

        switch (typeof value) {
        case 'string':
            return quote(value);

        case 'number':

// JSON numbers must be finite. Encode non-finite numbers as null.

            return isFinite(value) ? String(value) : 'null';

        case 'boolean':
        case 'null':

// If the value is a boolean or null, convert it to a string. Note:
// typeof null does not produce 'null'. The case is included here in
// the remote chance that this gets fixed someday.

            return String(value);

// If the type is 'object', we might be dealing with an object or an array or
// null.

        case 'object':

// Due to a specification blunder in ECMAScript, typeof null is 'object',
// so watch out for that case.

            if (!value) {
                return 'null';
            }

// Make an array to hold the partial results of stringifying this object value.

            gap += indent;
            partial = [];

// Is the value an array?

            if (Object.prototype.toString.apply(value) === '[object Array]') {

// The value is an array. Stringify every element. Use null as a placeholder
// for non-JSON values.

                length = value.length;
                for (i = 0; i < length; i += 1) {
                    partial[i] = str(i, value) || 'null';
                }

// Join all of the elements together, separated with commas, and wrap them in
// brackets.

                v = partial.length === 0 ? '[]' : gap ?
                    '[\n' + gap + partial.join(',\n' + gap) + '\n' + mind + ']' :
                    '[' + partial.join(',') + ']';
                gap = mind;
                return v;
            }

// If the replacer is an array, use it to select the members to be stringified.

            if (rep && typeof rep === 'object') {
                length = rep.length;
                for (i = 0; i < length; i += 1) {
                    if (typeof rep[i] === 'string') {
                        k = rep[i];
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }
            } else {

// Otherwise, iterate through all of the keys in the object.

                for (k in value) {
                    if (Object.prototype.hasOwnProperty.call(value, k)) {
                        v = str(k, value);
                        if (v) {
                            partial.push(quote(k) + (gap ? ': ' : ':') + v);
                        }
                    }
                }
            }

// Join all of the member texts together, separated with commas,
// and wrap them in braces.

            v = partial.length === 0 ? '{}' : gap ?
                '{\n' + gap + partial.join(',\n' + gap) + '\n' + mind + '}' :
                '{' + partial.join(',') + '}';
            gap = mind;
            return v;
        }
    }

// If the JSON object does not yet have a stringify method, give it one.

    if (typeof JSON.stringify !== 'function') {
        JSON.stringify = function (value, replacer, space) {

// The stringify method takes a value and an optional replacer, and an optional
// space parameter, and returns a JSON text. The replacer can be a function
// that can replace values, or an array of strings that will select the keys.
// A default replacer method can be provided. Use of the space parameter can
// produce text that is more easily readable.

            var i;
            gap = '';
            indent = '';

// If the space parameter is a number, make an indent string containing that
// many spaces.

            if (typeof space === 'number') {
                for (i = 0; i < space; i += 1) {
                    indent += ' ';
                }

// If the space parameter is a string, it will be used as the indent string.

            } else if (typeof space === 'string') {
                indent = space;
            }

// If there is a replacer, it must be a function or an array.
// Otherwise, throw an error.

            rep = replacer;
            if (replacer && typeof replacer !== 'function' &&
                    (typeof replacer !== 'object' ||
                    typeof replacer.length !== 'number')) {
                throw new Error('JSON.stringify');
            }

// Make a fake root object containing our value under the key of ''.
// Return the result of stringifying the value.

            return str('', {'': value});
        };
    }


// If the JSON object does not yet have a parse method, give it one.

    if (typeof JSON.parse !== 'function') {
        JSON.parse = function (text, reviver) {

// The parse method takes a text and an optional reviver function, and returns
// a JavaScript value if the text is a valid JSON text.

            var j;

            function walk(holder, key) {

// The walk method is used to recursively walk the resulting structure so
// that modifications can be made.

                var k, v, value = holder[key];
                if (value && typeof value === 'object') {
                    for (k in value) {
                        if (Object.prototype.hasOwnProperty.call(value, k)) {
                            v = walk(value, k);
                            if (v !== undefined) {
                                value[k] = v;
                            } else {
                                delete value[k];
                            }
                        }
                    }
                }
                return reviver.call(holder, key, value);
            }


// Parsing happens in four stages. In the first stage, we replace certain
// Unicode characters with escape sequences. JavaScript handles many characters
// incorrectly, either silently deleting them, or treating them as line endings.

            text = String(text);
            cx.lastIndex = 0;
            if (cx.test(text)) {
                text = text.replace(cx, function (a) {
                    return '\\u' +
                        ('0000' + a.charCodeAt(0).toString(16)).slice(-4);
                });
            }

// In the second stage, we run the text against regular expressions that look
// for non-JSON patterns. We are especially concerned with '()' and 'new'
// because they can cause invocation, and '=' because it can cause mutation.
// But just to be safe, we want to reject all unexpected forms.

// We split the second stage into 4 regexp operations in order to work around
// crippling inefficiencies in IE's and Safari's regexp engines. First we
// replace the JSON backslash pairs with '@' (a non-JSON character). Second, we
// replace all simple value tokens with ']' characters. Third, we delete all
// open brackets that follow a colon or comma or that begin the text. Finally,
// we look to see that the remaining characters are only whitespace or ']' or
// ',' or ':' or '{' or '}'. If that is so, then the text is safe for eval.

            if (/^[\],:{}\s]*$/
                    .test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, '@')
                        .replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, ']')
                        .replace(/(?:^|:|,)(?:\s*\[)+/g, ''))) {

// In the third stage we use the eval function to compile the text into a
// JavaScript structure. The '{' operator is subject to a syntactic ambiguity
// in JavaScript: it can begin a block or an object literal. We wrap the text
// in parens to eliminate the ambiguity.

                j = eval('(' + text + ')');

// In the optional fourth stage, we recursively walk the new structure, passing
// each name/value pair to a reviver function for possible transformation.

                return typeof reviver === 'function' ?
                    walk({'': j}, '') : j;
            }

// If the text is not JSON parseable, then a SyntaxError is thrown.

            throw new SyntaxError('JSON.parse');
        };
    }
}());
/* This is JSKOMMENT client-side Javascript
 * See http://code.google.com/p/jskomment 
 */

var JSKOMMENT = {}

/** The URL of the commenting system */
JSKOMMENT.url = '${JSKOMMENT_URL}';

/** The method to use with the server 
 * GUESS: auto-detection based on heuristics (recommended)
 * PROBE: auto-detection based on trying a test URL on the server 
 * ALL_GET: only GET HTTP methods, the main limitation is on the maximum size of queries and comments
 * JSONP:  only GET HTTP methods, and accepts JSONP as answer, same size limitation as ALL_GET
 * FLASH: uses GET and POST as application/x-www-form-urlencoded, requires flash on the client
 * REST: the best solution, using advanced XHR
 */
//JSKOMMENT.protocol = 'ALL_GET';
//JSKOMMENT.protocol = 'JSONP'; // cross-browser
//JSKOMMENT.protocol = 'FLASH';// cross-browser
//JSKOMMENT.protocol = 'REST';
//JSKOMMENT.protocol = 'PROBE';
JSKOMMENT.protocol = 'GUESS';

/** The public key of recaptcha */
JSKOMMENT.recaptchaPublicKey = "6Lfu-d0SAAAAAAwv15vNxDalA-4zqmNqFC3ib_bP";

/** The max number of comments before folding them */
JSKOMMENT.maxComments = ${JSKOMMENT_MAX};

/** The possible protocols, see JSKOMMENT.protocol, set by testConnection */
JSKOMMENT.supportedProtocols = {};

/** triggers an Ajax call with tailoring for certain protocols (see JSKOMMENT.protocol) */
JSKOMMENT.ajax = function (ajaxParams, preferredMethod, protocol) {
  
  var theprotocol = protocol || JSKOMMENT.protocol;
  
  if (theprotocol == 'PROBE') {
    theprotocol = JSKOMMENT.preferredProtocol();
  } 
  
  if (theprotocol == 'ALL_GET') {
    ajaxParams.type = 'get';
    ajaxParams.contentType = 'application/x-www-form-urlencoded'; // response in JSON    
    ajaxParams.accepts = {json: 'application/json'};
    ajaxParams.dataType = 'json';
    ajaxParams.data = {data: JSON.stringify(ajaxParams.data)};
  } else if (theprotocol == 'JSONP') {
    //ajaxParams.type = 'get';// automatically set by contentType
    ajaxParams.contentType = 'application/jsonp'; 
    ajaxParams.accepts = {jsonp: 'application/javascript'};// for JSON-P
    ajaxParams.dataType = 'jsonp'; // will modify HTTP header accept
    ajaxParams.data = {data: JSON.stringify(ajaxParams.data), contentType: 'application/jsonp'};    
  } else if (theprotocol == 'FLASH') {
    ajaxParams.type = preferredMethod;
    ajaxParams.contentType = 'application/x-www-form-urlencoded';// by flash we can not send in JSON directly 
    ajaxParams.accepts = {json: 'application/json'};
    ajaxParams.dataType = 'json';
    ajaxParams.data = {data: JSON.stringify(ajaxParams.data)};;
    ajaxParams.xhr  = JSKOMMENT.xhr;
  } else if (theprotocol == 'REST') {
    ajaxParams.type = preferredMethod;
    ajaxParams.dataType = 'json';
    ajaxParams.contentType = 'application/json'; // response in JSON
    ajaxParams.accepts = {json: 'application/json'};
    ajaxParams.data = JSON.stringify(ajaxParams.data);
  } else { throw "oops "+theprotocol; }
  
  $.ajax(ajaxParams);
};

/** sends the comment using the <FORM> received as elem */
JSKOMMENT.send = function (elem, options) {
  
  if (!$(elem).hasClass('jskomment')) {
    var msg = '${JSKOMMENT_CAPTCHA_ERROR}';
    window.console.log(msg);
    throw msg;
  }
  
  var data = {};
  $($(elem).find('.jskomment_form').serializeArray()).each(function(i,el) {
    data[el.name]=el.value;
  });
  
  // saving the name in local storage if possible
  try { if (localStorage) {localStorage.setItem('jskomment_username', $(elem).find('input[name="name"]').val());}} catch (e) {}
  
  if (options && $.inArray('recaptcha', options) != -1) {
    data['recaptcha_challenge_field']=Recaptcha.get_challenge();
    data['recaptcha_response_field']=Recaptcha.get_response();
  }
  
  // by default we use JSON-P with HTTP GET = Script node insertion in JQuery
  // cross-browser but limited to ~2k data
  var ajaxParams = {
    url: JSKOMMENT.url+'/p',
    dataType: 'json',
    data: data,
    success: function(val){
      JSKOMMENT.load(elem);
    },     
    error: function (xhr,err) {
      if (xhr.status == 403) {
        JSKOMMENT.captcha(elem);        
      }     
    }
  }
  
  try {
    JSKOMMENT.ajax(ajaxParams, 'POST');
  } catch(e) {
    console.log(e);
  }
  
  return false;
}

JSKOMMENT.display = function (array /* array of comment objects */) {
  
  var len = array.length;
  if (len == 0) { return ; }
  // we assume that all comments of this list refers to the same comment thread
  var title = array[0].title;
  var elem = $('[_title="'+title+'"]');
  
  elem.find('.jskomment_header').html($('<a href="javascript:void(0)">${JSKOMMENT_COMMENTS} <span class="jskomment_number">'+len+'</span></a>'));
  
  // if there are too may comments and we are not redrawing after having added a comment
  if (len>JSKOMMENT.maxComments && !elem.find('.jskomment_previous').attr('add_comment')) {
    elem.find('.jskomment_previous, .jskomment_add_comment').hide();
  }
  
  elem.find('.jskomment_previous').empty();
  
  // replacing the form
  // by a link
  elem.find('.jskomment_form').replaceWith(JSKOMMENT.createAddCommentElement());
  
  $(array).each(function (k,commentEntry) {
    if (commentEntry.title != title) { throw new Exception('oops, precondition failed'); };      var ePoster = $('<span class="jskomment_user"/>').text(commentEntry.name+' ');
                                                                                                                                                        var eContent = $('<span class="jskomment_commentval"/>').html(commentEntry.comment.replace(/\n/g,'<br/>'));
                                                                                                                                                        var eComment = $('<div class="jskomment_comment"/>').append(ePoster).append(eContent);
                                                                                                                                                        elem.find('.jskomment_previous').append(eComment);
  }
    );
    
    // now we can re-enable the form
    JSKOMMENT.enableForms();
    
}

/** batch load of comments, receives an array of requests */
JSKOMMENT.multiload = function(request) {
  // by default we use JSON-P with HTTP GET = Script node insertion in JQuery
  // cross-browser but limited to ~2k data
  var ajaxParams = {
    url: JSKOMMENT.url+'/sx',
    data: request,
    success: function(val){
      $(val).each(function (k,array) {
        JSKOMMENT.display(array);
      });
    },
    error: function(e) { 
      //throw "fr";
      console.error("err");
      console.log((e.error().responseText)); 
      console.log(JSON.parse(e.error().responseText)); 
      //console.error(e.error()); 
      
    }
  }
  
  // POST is the preferred method
  // from a conceptual REST view point GET would be better
  // but in this case the query can be really long
  JSKOMMENT.ajax(ajaxParams, 'POST'); 
}

/** loads comments from the server and display them */
JSKOMMENT.load = function (elem) {
  if (!$(elem).hasClass('jskomment')) {
    var msg = '${JSKOMMENT_CAPTCHA_ERROR}';
    window.console.log(msg);
    throw msg;
  }
  JSKOMMENT.ajax({
    url: JSKOMMENT.url+'/s',
    data : {title:$(elem).attr('_title')},
                 success: JSKOMMENT.display
  }, 'GET');
}

/** returns a clickable DOM element to add a comment
 * For instance, <a>Click to add a comment</a>
 */
JSKOMMENT.createAddCommentElement = function () {
  var addCommentLink = $(document.createElement('a'));
  addCommentLink.attr('href','javascript:void(0)');
  addCommentLink.attr('class','jskomment_add_comment');
  addCommentLink.text('${JSKOMMENT_ADD_COMMENT}');
  
  addCommentLink.click(function() {
    var clicked = this; // this is bound by click
    $(clicked).hide();
    var elem = $(clicked).parents('.jskomment');
    elem.find('.jskomment_previous').show();
    elem.find('.jskomment_previous').attr('add_comment', true);
    var title = elem.attr('_title');
    var name='${JSKOMMENT_PSEUDO}';
    try { name = localStorage.getItem('jskomment_username') || name; } catch (e) {}
    var form = $('<form class="jskomment_form jskomment_add_comment">'
    +'<input id="title" type="hidden" name="title" value="'+title+'"/>'
    +'<div class="jskomment_input1">${JSKOMMENT_LABEL}<input type="text" name="name" size="10" value="'+name+'"/> </div>'
    +'<div class="jskomment_commentval"><textarea class="jskomment_input2" rows="6" cols="32" name="comment" value="${JSKOMMENT_YOUR}"/></div>'
    +'<div class="jskomment_submit"><input class="jskomment_button" name="submit" type="submit" value="${JSKOMMENT_SUBMIT}"/></div>'
    +'</form>');
    
    form.submit(
      function (ev) {
        JSKOMMENT.disableForms();
        JSKOMMENT.send($(ev.target).parents('.jskomment')); 
        return false;
      }
    );
    $(clicked).parents('.jskomment').append(form);
    $(clicked).remove();
    $('<div class="jskomment_recaptcha"></div>').appendTo(form);    
  }); // end click function
    return addCommentLink;
};

/** inits a commenting section */
JSKOMMENT.init = function (elem) {
  
  if (!$(elem).hasClass('jskomment')) {
    var msg = '${JSKOMMENT_CAPTCHA_ERROR}';
    window.console.log(msg);
    throw msg;
  }
  
  var title = $(elem).attr('title');
  if (title === undefined || title === "") {
    title = document.location.href;
  }
  // setting the title in _title
  // because the browser uses this field as tooltip
  $(elem).attr('_title',title);
  $(elem).attr('title','${JSKOMMENT_POWERED} jskomment');
  
  var jskomment_header = $('<div class="jskomment_header"></div>');
  jskomment_header.click(function() {$(elem).find('.jskomment_previous, .jskomment_add_comment').toggle();});
  jskomment_header.appendTo(elem);
  var jskomment_previous = $('<div class="jskomment_previous"></div>');
  jskomment_previous.appendTo(elem);
  
  var addCommentLink = JSKOMMENT.createAddCommentElement();
  addCommentLink.appendTo($(elem));
  
  
}; // end function init

// uses a test web service on the server to check which protocols are supported on the client browser */
JSKOMMENT.testConnection = function(callback) {
  JSKOMMENT.ajax({
    url: JSKOMMENT.url+'/t',
    data : 'REST',
    success: function(response) {
      if (response==='REST') { JSKOMMENT.supportedProtocols['REST'] = 'ok'; }
    }
  }, 'POST', 'REST');
  if (JSKOMMENT.usingFlash) { 
    JSKOMMENT.ajax({
      url: JSKOMMENT.url+'/t',
      data : 'FLASH',
      success: function(response) {
        if (response==='FLASH') { JSKOMMENT.supportedProtocols['FLASH'] = 'ok'; }
      }
    }, 'POST', 'FLASH');
  }
  JSKOMMENT.ajax({
    url: JSKOMMENT.url+'/t',
    data : 'JSONP', // for JSONP, the response must be a valid JS expression
    success: function(response) {
      if (response==='JSONP') { JSKOMMENT.supportedProtocols['JSONP'] = 'ok'; }
    }
  }, 'POST', 'JSONP');
  JSKOMMENT.ajax({
    url: JSKOMMENT.url+'/t',
    data : 'ALL_GET',
    success: function(response) {
      if (response==='ALL_GET') { JSKOMMENT.supportedProtocols['ALL_GET'] = 'ok'; }
    }
  }, 'POST', 'ALL_GET');  
};

/** guesses a protocol that is supported by the browser, ideally REST with cross-domain support */
JSKOMMENT.guessProtocol = function() {
  /** Can we use XMLHttpRequest for cross-domain HTTP POST? 
   * @see http://www.w3.org/TR/XMLHttpRequest2/
   * @see http://hacks.mozilla.org/2009/07/cross-site-xmlhttprequest-with-cors/
   */
  if ((new XMLHttpRequest()).withCredentials !== undefined) {
    JSKOMMENT.protocol = 'REST';
  } else 
    if (JSKOMMENT.usingFlash) {    
      JSKOMMENT.protocol = 'FLASH';
    } else 
      // we always default JSONP
      JSKOMMENT.protocol = 'JSONP';
    
}

/** returns the client preferred protocol based on probing data obtained beforehand */
JSKOMMENT.preferredProtocol = function() {
  if ('REST' in JSKOMMENT.supportedProtocols) return 'REST';
                 if ('FLASH' in JSKOMMENT.supportedProtocols) return 'FLASH';
                     if ('JSONP' in JSKOMMENT.supportedProtocols) return 'JSONP';
                     if ('ALL_GET' in JSKOMMENT.supportedProtocols) return 'ALL_GET';
                     return 'JSONP';
}


// main main
JSKOMMENT.main = function () {
  
  
  // loading recaptcha
  // see http://code.google.com/apis/recaptcha/docs/display.html#AJAX
  $.getScript('http://www.google.com/recaptcha/api/js/recaptcha_ajax.js');
  
  $(document).ready(function(){
    
    // in order to save bandwidth (delivering the SWF object)
    // we don't enable flash if XMLHttpRequest is available
    // the object swfobject is automatically added to the generated js (see EmbedServlet)
    // this has to be in $(document).ready() because we use DOM elements to append the SWF
    
    //else {JSKOMMENT.mainContinue();};
    if (window.swfobject) 
    {
      var flash = $(document.createElement('div'));
      flash.attr({
        id:  "jskomment_flash"
      });
      flash.appendTo($('body'));
      swfobject.embedSWF(
        JSKOMMENT.url+'/swfhttprequest.swf',
        'jskomment_flash',"0", "0", "9.0.0", false, false, 
        {allowscriptaccess:'always'}, {allowscriptaccess:'always'},
        function(e) {
          if (e.success) {  
            if (console) console.log('flash enabled');
                                     JSKOMMENT.usingFlash = true;
            JSKOMMENT.xhr  = function(){return new window.SWFHttpRequest();};
            // set timeout is required
            // so that we are (almost) sure that it is really loaded
            setTimeout(JSKOMMENT.mainContinue, 500);
          }
          else {JSKOMMENT.mainContinue();}
        }
            );
    } else {JSKOMMENT.mainContinue();}
    
    // and finally we load the css
    var css = $(document.createElement('link'));
    css.attr({
      rel:  "stylesheet",
      type: "text/css",
      href: "",
      // Desactivate HREF comment file in order to permit each THEME to add its own CSS FILE for JSKOMMENT
      // href: "${BASE_URL}/${JSKOMMENT_CSS}"
    });
    css.appendTo($('head'));
  }); // end DOM ready
};


// continue once flash is loaded
JSKOMMENT.mainContinue = function () {
  
  if (JSKOMMENT.protocol === 'PROBE') {
    JSKOMMENT.testConnection();
  }
  if (JSKOMMENT.protocol === 'GUESS') {
    JSKOMMENT.guessProtocol();
  }
  
  // we must wait for testConnection to complete
  setTimeout(function() {
    // adding the form top enter new comments
    $('.jskomment').each(function(k,elem) { 
      // adding the UI elements
      JSKOMMENT.init(elem);
    });
    
    var request = [];
    $('.jskomment').each(function(k,elem) { 
      // requesting all comments
      request.push({title:$(elem).attr('_title')});
      });
      JSKOMMENT.multiload(request);
      
    }, 500);
  };
  
  //used for recaptcha
  JSKOMMENT.uniqid = function  (prefix, more_entropy) {
    // +   original by: Kevin van Zonneveld (http://kevin.vanzonneveld.net)
    // +    revised by: Kankrelune (http://www.webfaktory.info/)
    // %        note 1: Uses an internal counter (in php_js global) to avoid collision
    // *     example 1: uniqid();
    // *     returns 1: 'a30285b160c14'
    // *     example 2: uniqid('foo');
    // *     returns 2: 'fooa30285b1cd361'
    // *     example 3: uniqid('bar', true);
    // *     returns 3: 'bara20285b23dfd1.31879087'
    
    if (typeof prefix == 'undefined') {
      prefix = "";
    }
    
    var retId;
    var formatSeed = function (seed, reqWidth) {
      seed = parseInt(seed,10).toString(16); // to hex str
      if (reqWidth < seed.length) { // so long we split
            return seed.slice(seed.length - reqWidth);
      }
      if (reqWidth > seed.length) { // so short we pad
            return Array(1 + (reqWidth - seed.length)).join('0')+seed;
      }
      return seed;
    };
    
    // BEGIN REDUNDANT
    if (!this.php_js) {
      this.php_js = {};
    }
    // END REDUNDANT
    if (!this.php_js.uniqidSeed) { // init seed with big random int
        this.php_js.uniqidSeed = Math.floor(Math.random() * 0x75bcd15);
    }
    this.php_js.uniqidSeed++;
    
    retId  = prefix; // start with prefix, add current milliseconds hex string
    retId += formatSeed(parseInt(new Date().getTime()/1000,10),8);
    retId += formatSeed(this.php_js.uniqidSeed,5); // add seed hex string
    
    if (more_entropy) {
      // for more entropy we add a float lower to 10
      retId += (Math.random()*10).toFixed(8).toString();
    }
    
    return retId;
  }
  
  /**  disables the submit form */
  JSKOMMENT.disableForms = function() {
    var submit = $('.jskomment input[type="submit"]');
    submit.attr("disabled", true);
    submit.after($('<img class="modal-ajax-wait" src="'+JSKOMMENT.url+'/modal-ajax-wait.gif"/>'));
  }
  
  /**  re-enables the submit form */
  JSKOMMENT.enableForms = function() {
    var submit = $('.jskomment input[type="submit"]');
  submit.attr("disabled", false);
  submit.parent().find('.modal-ajax-wait').remove();
  }
  
  /** adds a captcha */
  JSKOMMENT.captcha = function (elem) {
    
    if (!$(elem).hasClass('jskomment')) {
    var msg = '${JSKOMMENT_CAPTCHA_ERROR}';
    throw msg;
    }
    
    var myrecaptcha = $(elem).find('.jskomment_recaptcha');
  var id = JSKOMMENT.uniqid();
  myrecaptcha.attr('id',id);
  Recaptcha.create(JSKOMMENT.recaptchaPublicKey,
                   id,
                   {
                     theme: "${JSKOMMENT_CAPTCHA_THEME}",
                   callback: 
                   function() {
                     var form = $(elem).find('.jskomment_form');
  form.unbind('submit');
              form.submit(function() {
                JSKOMMENT.disableForms();
                JSKOMMENT.send(elem, ['recaptcha']);
                myrecaptcha.hide();          
                return false;
              });
  Recaptcha.focus_response_field();
  JSKOMMENT.enableForms();
                   }
                   }
  );
  return false;
  }
  
JSKOMMENT.main();
