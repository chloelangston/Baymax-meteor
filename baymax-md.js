Illnesses = new Mongo.Collection("illnesses");



if (Meteor.isClient) {
  Meteor.subscribe("illnesses");
  // counter starts at 0
  Session.setDefault('page', 'home');

  // This code only runs on the client
  Template.body.helpers({
    currentPage: function(){
      return Session.get('page')
    }
  });

  Template.buttons.events({
    'click.button.clickChangesPage': function(event, template){
      Session.set('page', event.currentTarget.getAttribute('data-page'));
      console.log(template);
    }
  });

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

  Template.form.events({
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

Meteor.methods({
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
});

if (Meteor.isServer) {
  //Meteor.startup(function () {
  //  // code to run on server at startup
  //});

  Meteor.publish("illnesses", function(){
    return Illnesses.find();
  });
}
