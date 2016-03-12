// myplaceonline_final.js
//   The separation between myplaceonline.js and myplaceonline_final.js is 
//   because we have to ship core functions for PhoneGap initialization
//   (myplaceonline.js), after which myplaceonline_final.js is loaded remotely.
//   Code added to myplaceonline_final.js will be picked up dynamically, whereas
//   updates to myplaceonline.js must be updated and shipped in a new version
//   of the mobile app.
//
// =============================================================================
//
// Use the loose augmentation module pattern [1]. Variables and functions should
// be defined as locally-scoped and only explicitly exported [2] if part of the
// public API through property assignment at the end of the module function.
//
// [1] http://www.adequatelygood.com/JavaScript-Module-Pattern-In-Depth.html
// [2] http://www.w3.org/wiki/JavaScript_best_practices#Avoid_globals

var myplaceonline = function(mymodule) {
  
  var DEFAULT_DATE_FORMAT = "%A, %b %d, %Y";
  var DEFAULT_TIME_FORMAT = "%A, %b %d, %Y %-l:%M:%S %p";
  var queuedRequests = [];
  var queuedRequestThread = null;
  var notepadResetTimeout = null;
  
  $.noty.defaults.timeout = 3000;
  $.noty.defaults.layout = 'topCenter';
  
  $.ajaxPrefilter(function(options, originalOptions, xhr) {
    // "For AJAX requests other than GETs, extract the “csrf-token” from the
    // meta-tag and send as the “X-CSRF-Token” HTTP header."
    // http://api.rubyonrails.org/classes/ActionView/Helpers/CsrfHelper.html
    // http://stackoverflow.com/questions/7203304
    xhr.setRequestHeader("X-CSRF-Token", $("meta[name='csrf-token']").attr("content"));
  });

  // https://github.com/rails/jquery-ujs/wiki/ajax
  $(document).on('ajax:remotipartSubmit', 'form', function() {
    myplaceonline.consoleLog("ajax:remotipartSubmit: Submitting...");
    myplaceonline.showLoading();
  });

  $(document).on('ajax:complete', 'form', function(xhr, status) {
    myplaceonline.hideLoading();
    myplaceonline.consoleLog("ajax:complete");
    var contentType = status.getResponseHeader("Content-Type");
    // We expect a "successful" submission will return text/javascript
    // which will do something like navigate to the success page
    // (see MyplaceonlineController.may_upload). If it's text/html,
    // then there was probably some error, so we need to display it.
    if (myplaceonline.startsWith(contentType, "text/html")) {
      myplaceonline.showLoading();
      var html = $(status.responseText);
      var content = html.find(".ui-content");
      $(".ui-content").replaceWith(content);
      myplaceonline.ensureStyledPage();
      myplaceonline.hideLoading();
      myplaceonline.scrollTop();
    }
  });

  $(document).on('ajax:error', 'form', function(xhr, status, error) {
    myplaceonline.criticalError("Error submitting form: status: " + myplaceonline.getJSON(status) + ", error: " + myplaceonline.getJSON(error));
  });

  $(document).on("click", "#mainbutton", function(eventData) {
    if (eventData && eventData.shiftKey) {
      $("#mainButtonPopup").popup("open");
      myplaceonline.maybeFocus("#mainButtonPopup_search_container input");
      return false;
    } else if (eventData && eventData.ctrlKey) {
      myplaceonline.navigate("/");
      return false;
    } else {
      return true;
    }
  });

  // http://view.jquerymobile.com/master/demos/listview-autocomplete-remote/
  function hookListviewSearch(list, url, afterload) {
    list.on("listviewbeforefilter", function(e, data) {
      var $ul = $(this);
      var $input = $(data.input);
      var value = $input.val();
      if (value && value.length > 0) {
        listviewSearch($ul, url, value, afterload);
      }
    });
  }
  
  function listviewSearch(list, url, value, afterload) {
    if (!list[0].allLoaded) {
      myplaceonline.jqmSetListMessage(list, "Searching...");
      var data = {
        value: value
      };
      $.ajax({
        url: url,
        dataType: "json",
        context: list,
        data: data
      }).done(function(data, textStatus, jqXHR) {
        myplaceonline.jqmSetList(this, $(data));
        this[0].allLoaded = true;
        if (afterload) {
          afterload(this);
        }
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myplaceonline.jqmSetListMessage(this, "Error, please try again.");
      });
    }
  }

  function hookListviewEnter(listInput, listIdentifier) {
    listInput.keyup(function(e) {
      if (e.which == 13) {
        var searchList = $(listIdentifier + " li:not(.ui-screen-hidden)");
        if (searchList.size() > 0) {
          e.preventDefault();
          myplaceonline.navigate(searchList.filter(":first").children("a").attr("href"));
        }
      }
      return true;
    });
  }

  function getRemoteString(destination, length) {
    myplaceonline.showLoading();
    var url = "/api/randomString";
    if (length) {
      length = parseInt(length);
      if (length > 0) {
        url += "?length=" + length;
      }
    }
    $.ajax({
      url: url,
      dataType: "json",
      context: destination
    }).done(function(data, textStatus, jqXHR) {
      this.val(data.randomString);
    }).fail(function(jqXHR, textStatus, errorThrown) {
      myplaceonline.createErrorNotification("Could not execute " + url + ": " + textStatus);
    }).complete(function(jqXHR, textStatus) {
      myplaceonline.hideLoading();
    });
  }

  function get_index_from_id(obj) {
    var id = $(obj).data("nameprefix");
    if (id) {
      id = id.substring(id.lastIndexOf('[') + 1);
      id = id.substring(0, id.indexOf(']'));
      id = parseInt(id);
      if (isNaN(id)) {
        id = -1;
      }
      return id;
    }
    return -1;
  }

  function isArray(obj) {
    return Object.prototype.toString.call(obj) === '[object Array]';
  }

  function get_name_as_id(namePrefix) {
    return namePrefix.replace(/\[/g, '_').replace(/\]/g, '');
  }

  function formAddItem(link, namePrefix, deletePlaceholder, items, singletonMessage, nonIndexBased) {
    var index = -1;
    var itemswrapper = $(link).parents(".itemswrapper").first();
    if (itemswrapper.length == 0) {
      alert('API error: formAddItem call should be within DIV with class itemswrapper');
    }
    var itemswrapper_id = itemswrapper.attr("id");
    var itemwrappers = itemswrapper.find(".itemwrapper");
    if (!nonIndexBased) {
      itemwrappers.each(function() {
        var id = get_index_from_id($(this));
        if (id > index) {
          index = id;
        }
      });
    }
    index++;
    
    var has_position = false;
    
    //if (singletonMessage && itemwrappers.length > 0) {
    //  alert(singletonMessage);
    //  return false;
    //}
    
    var html = "<div class='itemwrapper " + itemswrapper_id + "' data-nameprefix='" + namePrefix;
    if (!nonIndexBased) {
      html += "[" + index + "]";
    }
    html += "'>";
    var toFocus = null;
    var i;
    var idPrefix = get_name_as_id(namePrefix);
    var futures = [];
    for (i = 0; i < items.length; i++) {
      var item = items[i];
      var itemNamePieces = null;
      if (item.name) {
        itemNamePieces = item.name.split('.');
      } else {
        itemNamePieces = new Array(1);
        itemNamePieces[0] = item.name;
      }
      
      var id = idPrefix;
      if (!nonIndexBased) {
        id += "_" + index;
        for (var j = 0; j < itemNamePieces.length; j++) {
          id += "_" + itemNamePieces[j];
        }
      }
      
      var name = namePrefix;
      if (!nonIndexBased) {
        name += "[" + index + "]";
        for (var j = 0; j < itemNamePieces.length; j++) {
          name += "[" + itemNamePieces[j] + "]";
        }
      }
      
      var cssclasses = '';
      if (item.autofocus && !toFocus) {
        toFocus = id;
      }
      if (item.classes) {
        cssclasses += item.classes + ' ';
      }
      
      var defaultValue = "";
      if (item.value) {
        defaultValue = item.value;
      }
      
      defaultValue = defaultValue.replace(/'/g, '').replace(/"/g, '');
      
      if (item.type == "date") {
        // Options should match app/helps/application_helper.rb myp_date_field
        html += "<p><input type='" + (myplaceonline.isFocusAllowed() ? "text" : "text") + "' id='" + id + "' name='" + name + "' placeholder='" + item.placeholder + "' value='" + defaultValue + "' class='" + cssclasses + "' data-role='datebox' data-datebox-mode='calbox' data-datebox-override-date-format='" + DEFAULT_DATE_FORMAT + "' data-datebox-use-focus='true' data-datebox-use-clear-button='true' data-datebox-use-modal='false' data-datebox-cal-use-pickers='true' data-datebox-cal-year-pick-min='-100' data-datebox-cal-year-pick-max='10' data-datebox-cal-no-header='true' /></p>";
      } else if (item.type == "random") {
        // Duplicated in views/myplaceonline/_generaterandom.html.erb
        html += '<div data-role="collapsible"><h3>' + item.heading + '</h3><p><input type="' + (myplaceonline.isFocusAllowed() ? "number" : "text") + '" class="generate_password_length" value="" placeholder="' + item.lengthplaceholder + '" /></p><p><a href="#" class="ui-btn" onclick="myplaceonline.getRemoteString(' + item.destination + ', $(this).parents(\'div\').first().find(\'.generate_password_length\').val()); return false;">' + item.button + '</a></p></div>';
      } else if (item.type == "textarea") {
        html += "<p><textarea id='" + id + "' name='" + name + "' placeholder='" + item.placeholder + "' class='" + cssclasses + "'></textarea></p>";
      } else if (item.type == "checkbox") {
        html += "<p><label for='" + id + "'>" + item.placeholder + "</label><input type='checkbox' id='" + id + "' name='" + name + "' class='" + cssclasses + "' value='1' /></p>";
      } else if (item.type == "select") {
        html += "<p><select id='" + id + "' name='" + name + "' class='" + cssclasses + "'><option value=''>" + item.placeholder + "</option>";
        for (var j = 0; j < item.options.length; j++) {
          html += "<option value='" + item.options[j][1] + "'>" + item.options[j][0] + "</option>";
        }
        html += "</select></p>";
      } else if (item.type == "renderpartial") {
        item.namePrefix = name;
        item.id = "remote_placeholder_" + id;
        html += "<p id='" + item.id + "'>Loading...</p>";
        futures.push(item);
      } else {
        var inputType = item.type;
        if (item.type == "position") {
          inputType = "hidden";
          has_position = true;
        }
        if (!myplaceonline.isFocusAllowed()) {
          if (inputType != "file" && inputType != "hidden") {
            inputType = "text";
          }
        }
        html += "<p><input type='" + inputType + "' id='" + id + "' name='" + name + "' placeholder='" + item.placeholder + "' value='" + defaultValue + "' class='" + cssclasses + "'";
        if (item.step) {
          html += " step='" + item.step + "'";
        }
        html += " /></p>";
      }
    }
    html += "<p><a href='#' onclick='return myplaceonline.formRemoveItem(this);' class='ui-btn ui-btn-icon-left ui-icon-delete ui-btn-inline'>" + deletePlaceholder + "</a></p>";
    html += "</div>";
    form_add_item_set_html($(link), html, toFocus);
    if (futures.length > 0) {
      myplaceonline.showLoading();
    }
    if (has_position) {
      form_set_positions(link);
    }
    if (futures.length > 0) {
      myplaceonline.saveCollapsibleStates();
    }
    for (i = 0; i < futures.length; i++) {
      var item = futures[i];
      var url = "/api/renderpartial.json";
      $.ajax({
        url: url,
        dataType: "json",
        contentType: "application/json",
        type: "POST",
        data: JSON.stringify(item),
        context: item
      }).done(function(data, textStatus, jqXHR) {
        if (data.success) {
          $("#" + this.id).html(data.html);
        } else {
          $("#" + this.id).html("<b>Error:</b> " + data.error);
        }
        myplaceonline.ensureStyledPage();
        // Fire off any onPageLoad events
        $.mobile.pageContainer.trigger("pagecontainershow");
        scrollDown(200);
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myplaceonline.createErrorNotification("Could not execute " + url + ": " + textStatus);
      }).complete(function(jqXHR, textStatus) {
        myplaceonline.hideLoading();
      });
    }
    return false;
  }

  function scrollDown(amount, easingType) {
    if (!easingType) {
      easingType = "easeInSine";
    }
    $('html, body').stop().animate({
      scrollTop : $(window).scrollTop() + amount
    }, 650, easingType);
  }

  function html_calculation_operand(item, heading, idPrefix, namePrefix, input_name) {
    return '<div data-role="collapsible" data-collapsed="false"><h3>' + heading + '</h3><div data-role="collapsible-set"><div data-role="collapsible" data-collapsed="false"><h3>' + item.constant + '</h3><input type="text" id="' + idPrefix + '_' + input_name + '_constant_value" name="' + namePrefix + '[' + input_name + '][constant_value]" placeholder="' + item.constant_value + '" value="" class="" /></div><div data-role="collapsible" data-collapsed="true"><h3>' + item.sub_element + '</h3><div class="itemswrapper"><p><p><a href="#" onclick="return myplaceonline.formAddItem(this, \'' + namePrefix + '[' + input_name + '][calculation_element_attributes]\', \'' + item.delete + '\', [{ type: \'calculation_element\', left_heading: \'' + item.left_heading + '\', right_heading: \'' + item.right_heading + '\', constant_value: \'' + item.constant + '\', sub_element: \'' + item.sub_element + '\', constant: \'' + item.constant_value + '\', create: \'' + item.create + '\', delete: \'' + item.delete + '\', singleton: \'' + item.singleton + '\' }], \'' + item.singleton + '\', true);" class="ui-btn">' + item.create + '</a></p></p></div></div></div></div>';
  }

  function form_add_item_set_html(insertBefore, html, toFocus) {
    $(html).insertBefore(insertBefore);
    $(insertBefore).parent().trigger('create');
    if (toFocus) {
      myplaceonline.maybeFocus("#" + toFocus);
    }
  }

  function formRemoveItem(link) {
    var div = $(link).parents(".itemwrapper").first();
    var namePrefix = div.data("nameprefix");
    var idPrefix = get_name_as_id(namePrefix);
    var destroy_id = idPrefix + "__destroy";
    var destroy_name = namePrefix + "[_destroy]";
    var existing_destroy = $("#" + destroy_id);
    if (existing_destroy.length) {
      existing_destroy.val("1");
    } else {
      var html = "<input type='hidden' id='" + destroy_id + "' name='" + destroy_name + "' value='1' />";
      $(html).insertBefore(div);
    }
    div.hide();
    return false;
  }

  function formMoveItem(obj, direction) {
    // Find the itemwrapper for our obj
    var itemwrapper = $(obj).parents(".itemwrapper").first();

    if (direction == 1) {
      var search = itemwrapper[0].nextElementSibling;
      while (search) {
        if ($(search).hasClass("itemwrapper")) {
          itemwrapper.remove();
          $(search).after(itemwrapper);
          itemwrapper.trigger('create');
          break;
        }
        search = search.nextElementSibling;
      }
    } else if (direction == -1) {
      var search = itemwrapper[0].previousElementSibling;
      while (search) {
        if ($(search).hasClass("itemwrapper")) {
          itemwrapper.remove();
          $(search).before(itemwrapper);
          itemwrapper.trigger('create');
          break;
        }
        search = search.previousElementSibling;
      }
    }
    
    form_set_positions(obj);
    return false;
  }

  function form_get_item_wrappers(obj) {
    var itemswrapper = $(obj).parents(".itemswrapper").first();
    var itemswrapper_id = itemswrapper.attr("id");
    return itemswrapper.find("." + itemswrapper_id);
  }

  function form_set_positions(obj) {
    var itemswrapper = $(obj).parents(".itemswrapper").first();
    var data_position_field = itemswrapper.data("position-field");
    var itemswrapper_id = itemswrapper.attr("id");
    var itemwrappers = itemswrapper.find("." + itemswrapper_id);
    var position = 1;
    itemwrappers.each(function() {
      var itemwrapper = $(this);
      var itemwrapper_nameprefix = itemwrapper.data("nameprefix");
      var position_id = get_name_as_id(itemwrapper_nameprefix) + "_" + data_position_field;
      $("#" + position_id).val(position);
      position++;
    });
  }

  function objectExtractId(obj) {
    return href_extract_id($(obj).attr("href"));
  }

  function href_extract_id(href) {
    var x = href.lastIndexOf("/"); 
    if (x != -1) {
      href = href.substring(x + 1);
    }
    return href;
  }

  function queueRequest(request) {
    queuedRequests.push(request);
    if (!queuedRequestThread) {
      queuedRequestThread = setTimeout(processQueuedRequest, 1000);
    }
  }

  function processQueuedRequest() {
    var newestRequests = {};
    for (var i = 0; i < queuedRequests.length; i++) {
      var request = queuedRequests[i];
      var existingRequest = newestRequests[request.url];
      if (existingRequest) {
        if (request.timestamp > existingRequest.timestamp) {
          newestRequests[request.url] = request;
        }
      } else {
        newestRequests[request.url] = request;
      }
    }
    for (var url in newestRequests) {
      var request = newestRequests[url];
      request.presend();
      $.ajax({
        url: request.url,
        method: request.method,
        dataType: request.dataType,
        data: request.data
      }).done(function(data, textStatus, jqXHR) {
        request.done(data, textStatus, jqXHR);
      }).fail(function(jqXHR, textStatus, errorThrown) {
        request.fail(jqXHR, textStatus, errorThrown);
      });
    }
    queuedRequests = [];
    queuedRequestThread = null;
  }

  function getBorderTitle(context) {
    var result = context.html();
    result = result.replace(/ \(.*\)/g, "");
    return result;
  }

  function notepadChanged(rte_wrapper_id, url, pendingSave, saving, saved, new_data) {
    queueRequest({
      url: url,
      method: "PATCH",
      dataType: "script",
      timestamp: new Date().getTime(),
      presend: function() {
        var titleObj = $(rte_wrapper_id).parents(".myplet_border").first().find(".myplet_border_title_content").first();
        titleObj.html(getBorderTitle(titleObj) + " (" + saving + ")");
      },
      data: {
        suppress_navigate: true,
        notepad: {
          notepad_data: new_data
        }
      },
      done: function(data, textStatus, jqXHR) {
        var titleObj = $(rte_wrapper_id).parents(".myplet_border").first().find(".myplet_border_title_content").first();
        titleObj.html(getBorderTitle(titleObj) + " (" + saved + ")");
        window.setTimeout(function() {
          var titleObj = $(rte_wrapper_id).parents(".myplet_border").first().find(".myplet_border_title_content").first();
          titleObj.html(getBorderTitle(titleObj));
        }, 1500);
      },
      fail: function(jqXHR, textStatus, errorThrown) {
        var titleObj = $(rte_wrapper_id).parents(".myplet_border").first().find(".myplet_border_title_content").first();
        titleObj.html(getBorderTitle(titleObj));
        myplaceonline.createErrorNotification("Could not execute " + url + ": " + textStatus);
      }
    });
  }

  function quickFeedback(prompt_text) {
    var result = prompt(prompt_text);
    if (result) {
      var url = "/api/quickfeedback.json";
      $.ajax({
        url: url,
        method: "POST",
        dataType: "json",
        data: result
      }).done(function(data, textStatus, jqXHR) {
        myplaceonline.createSuccessNotification("Feedback submitted successfully");
      }).fail(function(jqXHR, textStatus, errorThrown) {
        myplaceonline.createErrorNotification("Could not execute " + url + ": " + textStatus);
      }).complete(function(jqXHR, textStatus) {
      });
    }
  }

  function addClass(obj, className) {
    if (!obj.hasClass(className)) {
      obj.addClass(className);
    }
  }

  function removeClass(obj, className) {
    if (obj.hasClass(className)) {
      obj.removeClass(className);
    }
  }

  function hideIfChecked(obj) {
    if (obj.checked) {
      addClass($(obj).parent().children("label").first(), "hiding");
      var objectToHide = $(obj).parent();
      var hideTimeout = window.setTimeout(function() {
        objectToHide.fadeOut();
      }, 1000);
      $(obj).data("myplaceonline-is-hiding", hideTimeout);
    } else {
      if ($(obj).data("myplaceonline-is-hiding")) {
        window.clearTimeout($(obj).data("myplaceonline-is-hiding"));
        removeClass($(obj).parent().children("label").first(), "hiding");
      }
    }
    return false;
  }

  function refreshWithParam(paramName, paramValue) {
    var url = removeParam(window.location.search, paramName);
    if (url.indexOf('?') == -1) {
      url += "?" + paramName + "=" + paramValue;
    } else {
      url += "&" + paramName + "=" + paramValue;
    }
    myplaceonline.navigate(window.location.pathname+url);
  }

  function removeParam(url, paramName) {
    var x = url.indexOf("?" + paramName);
    if (x == -1) {
      x = url.indexOf("&" + paramName);
      if (x != -1) {
        var y = url.indexOf('&', x + 1);
        if (y == -1) {
          url = url.substring(0, x);
        } else {
          url = url.substring(0, y);
        }
      }
    } else {
      var y = url.indexOf('&', x + 1);
      if (y == -1) {
        url = url.substring(0, x);
      } else {
        url = url.substring(0, y);
      }
    }
    return url;
  }

  function requestGPS(target, requesting_gps, latitude, longitude, geolocation_unavailable, copy_to_clipboard) {
    $(target).html("<p>" + requesting_gps + "</p>");
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(location) {
        var maplink = "https://www.google.com/maps/place/" + location.coords.latitude + "," + location.coords.longitude;
        $(target).html("<p>" + latitude + ": " + location.coords.latitude + ", " + longitude + ": " + location.coords.longitude + "</p><p>" + location.coords.latitude + "," + location.coords.longitude + "</p><p><button class='clipboardable' data-clipboard-text='" + location.coords.latitude + "," + location.coords.longitude + "' onclick='return false;'>" + copy_to_clipboard + "</button></p><p><a href='" + maplink + "' target='_blank'>" + maplink + "</a></p>");
        myplaceonline.ensureClipboard($(".clipboardable"));
      });
    } else {
      $(target).html("<p>" + geolocation_unavailable + "</p>");
    }
    return false;
  }

  function requestGPS2(onSuccess) {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(location) {
        onSuccess(location);
      });
    }
    return false;
  }

  function playFirstSong(search) {
    var audioElements = $(search).find("audio");
    if (audioElements.length) {
      audioElements[0].play();
    }
  }
  
  function playNextSong(search) {
    var audioElements = $(search).find("audio");
    if (audioElements.length) {
      for (var i = 0; i < audioElements.length - 1; i++) {
        if (!audioElements[i].paused) {
          audioElements[i].pause();
          audioElements[i + 1].play();
          break;
        }
      }
    }
  }
  
  function playPreviousSong(search) {
    var audioElements = $(search).find("audio");
    if (audioElements.length) {
      for (var i = 1; i < audioElements.length; i++) {
        if (!audioElements[i].paused) {
          audioElements[i].pause();
          audioElements[i - 1].play();
          break;
        }
      }
    }
  }
  
  function pauseSongs(search) {
    var audioElements = $(search).find("audio");
    if (audioElements.length) {
      for (var i = 0; i < audioElements.length; i++) {
        if (!audioElements[i].paused) {
          audioElements[i].pause();
        }
      }
    }
  }
  
  function onChangeCascade(myobj, transformValueFunc, parentSelector, childSelector, intermediateSelector, intermediateTransform) {
    var currentValue = $(myobj).val();
    if (transformValueFunc) {
      currentValue = transformValueFunc(currentValue);
    }
    var parent = $(myobj).parents(parentSelector).first();
    var searchResult = parent.find(childSelector).first();
    
    if (intermediateSelector) {
      var intermediate = parent.find(intermediateSelector).first().val();
      currentValue = intermediateTransform(currentValue, intermediate);
    }
    
    searchResult.val(currentValue.toFixed(2));
  }
  
  function toFloatSafe(someVal) {
    var result = parseFloat(someVal);
    if (!isFinite(result)) {
      result = 0;
    }
    return result;
  }
  
  function transformMultiply(x, y) {
    return x * y;
  }
  
  function setCsrfToken(token) {
    var metaTag = $("meta[name='csrf-token']");
    if (metaTag.length == 0) {
      $('<meta name="csrf-param" content="authenticity_token" />').appendTo('head');
      metaTag = $('<meta name="csrf-token" content="" />').appendTo('head');
    }
    metaTag.attr("content", token);
  }

  // Public API
  mymodule.hookListviewSearch = hookListviewSearch;
  mymodule.hookListviewEnter = hookListviewEnter;
  mymodule.getRemoteString = getRemoteString;
  mymodule.formAddItem = formAddItem;
  mymodule.formRemoveItem = formRemoveItem;
  mymodule.formMoveItem = formMoveItem;
  mymodule.objectExtractId = objectExtractId;
  mymodule.notepadChanged = notepadChanged;
  mymodule.quickFeedback = quickFeedback;
  mymodule.hideIfChecked = hideIfChecked;
  mymodule.refreshWithParam = refreshWithParam;
  mymodule.requestGPS = requestGPS;
  mymodule.requestGPS2 = requestGPS2;
  mymodule.playFirstSong = playFirstSong;
  mymodule.playNextSong = playNextSong;
  mymodule.playPreviousSong = playPreviousSong;
  mymodule.pauseSongs = pauseSongs;
  mymodule.onChangeCascade = onChangeCascade;
  mymodule.toFloatSafe = toFloatSafe;
  mymodule.transformMultiply = transformMultiply;
  mymodule.setCsrfToken = setCsrfToken;
  mymodule.listviewSearch = listviewSearch;

  return mymodule;

}(myplaceonline || {});

// jquery-mobile-datebox require global function callbacks
function dateboxCalendarClosed(update) {
  var timebox = $("#" + this.element.data("datetime-id"));
  timebox.data("calendar-id", this.element.attr("id"));
  timebox.datebox('open');
}

function dateboxTimeboxClosed(update) {
  var cal = $("#" + this.element.data("calendar-id"));
  var calDate = cal.datebox('getTheDate');
  calDate.setHours(update.date.getHours(), update.date.getMinutes(), update.date.getSeconds(), update.date.getMilliseconds());
  cal.datebox('setTheDate', calDate);
}
