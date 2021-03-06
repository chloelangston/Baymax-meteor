Illnesses = new Mongo.Collection("illnesses");


//$(".stomache").click(function(){
//  $(".stomache").hide();
//});
//
//$(".stomache").click(function(){
//  $(".stomache").show();
//});

if (Meteor.isClient) {
  Meteor.subscribe("illnesses");
  // counter starts at 0
  Session.setDefault('page', 'home');
  Session.setDefault('search', 'true');
  Session.set('glenn',"Your mom makes delicious meatloaf");
  Session.setDefault('processingSketch1', 'true');
  Session.setDefault('bodyPartSelected', 'chest');

  // This code only runs on the client
  Template.body.helpers({
    currentPage: function(){
      return Session.get('page');
    },
    ifSearch: function(){
      return Session.get('search');
    },
    glenn:function(){
      return Session.get('glenn');
    },
    processingSketch1: function(){
      return Session.get('processingSketch1');
    }
    //email: function(){
    //  return Meteor.user().email;
    //}
  });

  Template.body.events({
    'submit .name': function(event){
      event.preventDefault();
      var name = event.tartget.text.value;
    }
  })

  Template.bodyPartsLayer.helpers({

  })

  Template.bodyPartsLayer.events({
    'click .head': function(event, template){
      template.$('.head').css('opacity', 1);
      Session.set('bodyPartSelected', 'head');
    },
    'click .chest': function(event, template){
      template.$('.chest').css('opacity', 1);
      Session.set('bodyPartSelected', 'chest');
    },
    'click .stomache': function(event, template){
      template.$('.stomache').css('opacity', 1);
      Session.set('bodyPartSelected', 'stomache');
    },
    'click .arm1': function(event, template){
      template.$('.arm1').css('opacity', 1);
      Session.set('bodyPartSelected', 'arm1');
    },
    'click .arm2': function(event, template){
      template.$('.arm2').css('opacity', 1);
      Session.set('bodyPartSelected', 'arm2');
    },
    'click .leg': function(event, template){
      template.$('.leg').css('opacity', 1);
      Session.set('bodyPartSelected', 'leg');
    }
  })

  Template.buttons.events({
    'click.button.clickChangesPage': function(event, template){
      Session.set('page', event.currentTarget.getAttribute('data-page'));
      Session.set('processingSketch1', 'false');
      console.log(template);
    }
  });

  Template.home.helpers({
    email: function(){
      return Meteor.user().email;
    }
  })

  Template.illnessList.helpers({
    illnesses: function(){
      return Illnesses.find({});
    }
  });

  Template.illness.helpers({
    isOwner: function(){
      return this.owner === Meteor.userId();
    }
  });

  Template.illness.events({
    "click .toggle-checked": function () {
      // Set the checked property to the opposite of its current value
      Meteor.call("setChecked", this._id, ! this.checked);
    },
    "click .delete": function () {
      Meteor.call("deleteIllness", this._id);
    }
  });

  //Template.form.result = function(){
  //  return Session.get('webMdResponse') || "";
  //}

  Template.form.helpers({
    result: function(){
      return Session.get('webMdResponse') || "";
    },
    bodyPartSelected: function(){
      return Session.get('bodyPartSelected') || "";
    }
  })

  Template.form.events({
    'click input[type=button]': function(event) {
      event.preventDefault();
      //var searchTerm = event.target.description.value;
      //this logs in the browser!!!
      console.log("chloe");
      Session.set('ifSearch', 'true');
      var pillow = Meteor.call('getMdInfo', $('input[type=text]').val(), function(err, response){
        if(err){
          Session.set('getMdInfo', "error:" + err.reason);
        }
        Session.set('webMdResponse', response);

        console.log(Session.get('webMdResponse'));
        console.log('webMdResponse');
        console.log('getMdInfo');
      })//end Meteor.call
      console.log(pillow);
    },
    "submit": function (event) {
      // Prevent default browser form submit
      event.preventDefault();

      // Get value from form element
      var bodyPart = event.target.bodyPart.value;
      var painLevel = event.target.painLevel.value;
      var description = event.target.description.value;
      var lengthInDays = event.target.lengthInDays.value;

      console.log(bodyPart);
      // Insert a task into the collection
      Meteor.call("addIllness", bodyPart, painLevel, description, lengthInDays);

      // Clear form
      event.target.bodyPart.value = "";
      event.target.painLevel.value = "";
      event.target.description.value = "";
      event.target.lengthInDays.value = "";
    }
  });

  Accounts.ui.config({
    passwordSignupFields: "EMAIL_ONLY"
  });
}



  //
  //setPrivate: function (taskId, setToPrivate) {
  //  var task = Tasks.findOne(taskId);
  //
  //  // Make sure only the task owner can make a task private
  //  if (task.owner !== Meteor.userId()) {
  //    throw new Meteor.Error("not-authorized");
  //  }
  //
  //  Tasks.update(taskId, { $set: { private: setToPrivate } });
  //}


if (Meteor.isServer) {
  var cheerio = Meteor.npmRequire('cheerio');

  Meteor.startup(function () {
    //// code to run on server at startup
    //searchTerm = 'headache';
    Meteor.methods({
      getMdInfo: function(searchTerm) {
        var mdInfo;
        var searchTerm = 'headache';
        var url = 'http://www.webmd.com/search/search_results/default.aspx?query=' + searchTerm;
        HTTP.call('GET', url, {}, function (error, response) {
          console.log(error);
          console.log(Object.keys(response));
          var body = response.content;
          //console.log(body);
          $ = cheerio.load(body);
          console.log("glenn was here")
          console.log($('.searchResultsTitle').text());

          var nextURL = $('#searchResults > div:nth-child(2) > div.text_fmt > h2 > a').attr('href');
          HTTP.call('GET', nextURL, function (error, response) {
            var body2 = response.content;
            //console.log(body2);
            $ = cheerio.load(body2);
            mdInfo = $('.teaser_fmt').text();
            //logging headache info right below
            //console.log(mdInfo);
            console.log('glenn was here too')
            return mdInfo;

          })

        })
        return mdInfo;
      },
      addIllness: function (bodyPart, painLevel, description, lengthInDays) {
        // Make sure the user is logged in before inserting a task
        //if (! Meteor.userId()) {
        //  throw new Meteor.Error("not-authorized");
        //}

        Illnesses.insert({
          bodyPart: bodyPart,
          painLevel: painLevel,
          description: description,
          lengthInDays: lengthInDays,
          createdAt: new Date(), // current time
          owner: Meteor.userId(),
          email: Meteor.user().email
        });
      },
      deleteIllness: function (illnessId) {
        Illnesses.remove(illnessId);
      },
      setChecked: function (illnessId, setChecked) {
        Illnesses.update(illnessId, { $set: { checked: setChecked} });
      }

    })
  });

  Meteor.publish("illnesses", function(){
    return Illnesses.find();
  });
}
