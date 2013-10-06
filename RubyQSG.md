# The Evernote SDK for Ruby Quick Start Guide

The purpose of this guide is describing how to download, install and configure the Evernote SDK for Ruby. If everything goes as planned, this shouldn't take more than 10–15 minutes.

Our application will perform the following actions:

* Authenticate with the Evernote Cloud API using OAuth.
* List all of the notebooks in the authenticated user's account, their username and the total number of notes in their account.

## What You'll Need

Before we start working with the Evernote Cloud API, let's make sure everything we need is present and accounted for.

### Evernote API Key

If you don't already have an Evernote Cloud API Key, you can request one on [the Evernote Developer site](http://dev.evernote.com/support/api_key.php). The API key is made up of two pieces: a Consumer Key and a Consumer Secret. You'll need both of these to complete the sample app below. 

### Evernote Sandbox Account

[Sandbox](http://sandbox.evernote.com) is Evernote's development server. You'll need to create an account on that server for use with the sample app below. If you don't already have a Sandbox account, you can create one [here](https://sandbox.evernote.com/Registration.action).

### Ruby

The Ruby programming language runtime is installed by default on Mac OS X and most Unix-based operating systems (including Linux). This tutorial assumes you're using version 1.9.3 or higher of the Ruby runtime. To determine the version of Ruby running on your computer, issue the following command at the console:

	ruby -v

If your computer doesn't have Ruby installed, you can find information on how to do that on the [Ruby language website](http://www.ruby-lang.org/).

### RubyGems

The Evernote SDK for Ruby is available as a gem (a package format used by the popular RubyGems package manager). You'll need to [download and install RubyGems](http://rubygems.org/pages/download) if you haven't already, as we'll be using it to install a few packages upon which our sample app depends. Once you've installed it, issue this command in your terminal/console:

	gem --version

This will print the current version of RubyGems. This tutorial assumes you're using version 1.8.24 (the current version as of this writing). If the number displayed is lower, you would do well to update to the latest version by issuing the following command:

	gem update --system

*(Note: updating RubyGems may require root or administrative privileges.)*

### Sinatra

The sample application described in this chapter uses [Sinatra](http://sinatrarb.com), a popular web development framework for Ruby. Some familiarity with Sinatra will make this example easier to understand, but isn't required. 

Sinatra is available from RubyGems and can be installed using the `gem` command:

	gem install sinatra
	
Our sample app uses the current stable version of Sinatra, version 1.3.3.
	
## Installing the Evernote SDK for Ruby

The Evernote SDK for Ruby can be easily installed by issuing the following command:

	gem install evernote_oauth
	
This package includes the complete Evernote SDK and some additional functionality to make it simpler to work with the OAuth authentication protocol (which is required by the Evernote Cloud API).

We now have all of the necessary software installed to construct our sample application. Let's do that now.

## The Sample App

*(You can view [the complete sample app on Github](https://github.com/evernote/simple-api-client-example-ruby) if you have trouble following along here.)*

Our sample app is comprised of two Ruby source files:

1. `evernote_config.rb`, which contains a few bits of configuration information.
2. `en_oauth.rb`, the application source code.


### Configuration

`evernote_config.rb` will look something like this:

<script src="https://gist.github.com/3989818.js?file=evernote_config.rb"></script>

The two `require` statements at the top are for the [Ruby OAuth gem](http://oauth.rubyforge.org/), followed by the `evernote_oauth` gem. This gem depends on the `oauth` gem and implements the entire Evernote Cloud API, plus additional OAuth-related functionality.

Below that, we have our Consumer Key and Consumer Secret values (which should be set to the corresponding parts of your Evernote Cloud API Key).

Finally, we have a boolean variable `SANDBOX` which controls whether our app will connect to the Sandbox development server. If false, our app would connect to the production Evernote service.

### Our App's Components

Within `en_oauth.rb`, we have a few different pieces of our application: the `before` filter, the `helpers` functions, our `get` routes and a pair of simple ERB templates. 

First, let's cover what I'm lovingly calling "the preamble":

<script src="https://gist.github.com/4020133.js?file=en_auth.rb"></script>

First, we include the Sinatra gem and enable cookie-based sessions (part of Sinatra). Second, we include the current directory in the `$LOAD_PATH` (so we can load our configuration file). Finally, we load said configuration file. Pretty straightforward.

Now, on with the meat of the app...

#### `before`

This filter runs when the app is initialized and verifies that the `OAUTH_CONSUMER_KEY` and `OAUTH_CONSUMER_SECRET` constants have been set in `evernote_config.rb`. If either constant is initialized to empty string, the error message is displayed:

<script src="https://gist.github.com/3995397.js?file=en_oauth.rb"></script>

#### `helpers`

A collection of plain Ruby functions that will be used in our application. Many of them simply represent variables that we've abstracted out of the routes portion of the application. As it happens, this section also contains the calls to the Evernote Cloud API. Let's quickly look at each of these:

* **`auth_token`** stores the authentication token we'll be using to make calls against the Evernote Cloud API.
* **`client`** represents the instance of `EvernoteOAuth::Client`. It is instantiated using `auth_token` (if we have one), `OAUTH_CONSUMER_KEY`, `OAUTH_CONSUMER_SECRET` and `SANDBOX`.
* **`user_store`** and **`note_store`** are the two services of the Evernote Cloud API: the former deals with user and account information, the latter with the user's notes, notebooks, etc.
* **`en_user`** represents a single Evernote `User` instance retrieved from the Evernote Cloud API.
* **`notebooks`** contains a collection of `Notebook` objects as returned by the Evernote Cloud API when `NoteStore.listNotebooks()` is called.
* **`total_note_count`** is the only function in our app that performs logic beyond simply returning a value and deserves a little more explanation...

<script src="https://gist.github.com/3995544.js?file=en_oauth.rb"></script>

We begin with `filter`, a new (empty) instance of `NoteFilter`. Since we want to query the entire account, we won't be adding any additional filtering criteria ([see the full `NoteFilter` definition here](http://dev.evernote.com/documentation/reference/NoteStore.html#Struct_NoteFilter)).

Next, we call `findNoteCounts`, passing our `auth_token` and `filter` as parameters (the `false` parameter indicates that we don't want notes from the account's Trash container). `findNoteCounts` returns an instance of  `NoteCollectionCounts` — a hash of notebook GUIDs mapped to the number of notes in the corresponding notebook. Iterating over all of our notebooks, we ask `counts` (our instance of `NoteCollectionCounts`) for the number of notes in that notebook—using its GUID—and return the total of these counts. 

#### `get` Routes

Each instance of `get` in our app represents an HTTP request and a corresponding URL pattern. Our application has a total of seven routes. Four of them deal directly with our OAuth implementation and will be discussed in the next section. The remaining three are:

<script src="https://gist.github.com/3996447.js?file=en_oauth.rb"></script>

The root of our site, this route simply displays the `index` template (defined as `@@index` at the end of `en_auth.rb`) and prompts the user to begin the OAuth authentication process.

<script src="https://gist.github.com/3996450.js?file=en_oauth.rb"></script>

In this route, we first clear the `session` object (which is used to track the user's progress and state across a necessarily stateless web interaction), then redirect the user to `/` so they can begin the process again.

<script src="https://gist.github.com/3996456.js?file=en_oauth.rb"></script>

This method collects various information about the user's account (using methods defined in the `helpers` section of our app), adds them to the current `session` object and renders the `index` template. If there are any problems, the `rescue` block of our code is triggered and the `@last_error` variable is populated with the cause of the error and is sent to the `error` template (also defined at the end of `en_auth.rb`).

#### OAuth

As with most OAuth flows, our authentication takes places over a series of steps:

1. Retrieve a request token from the Evernote Cloud API. This token is used to request an authentication token in the next step.
2. Using the request token, send the user to the Evernote site where they will authenticate with their login credentials and authorize our application to access their account.
3. The Evernote website will redirect the user back to our defined callback URL and append, among other things, the authentication token we will use when making calls against the Evernote Cloud API.

This process is somewhat automated in our sample application (at least, in terms of user interaction). That is to say, as each step of the process is completed, the next step will be invoked automatically using Sinatra's `redirect` facility.

<script src="https://gist.github.com/3996720.js?file=en_oauth.rb"></script>

Here, we ask the Evernote Cloud API for our temporary request token. 

To start, we take the current URL as defined by the `request` object's `url` member, remove the `requesttoken` portion and replace it with `callback` to build our callback URL. Then, we call `client.authentication_request_token` to request our token (and sending the `callback_url` variable to tell the Evernote Cloud API where to send the response. If all of this goes well, the `session[:request_token]` is populated with the token value and the user is scuttled off to `/authorize`:

<script src="https://gist.github.com/3996790.js?file=en_auth.rb"></script>

Once we verify that `session[:request_token]` exists, we grab the `authorize_url` from the request token and send the user there where they'll be prompted to login with their Evernote account credentials and authorize our application to access their account. If `session[:requesttoken]` is *not* set, the user will see an error and be prompted to start the process over.

After successfully authenticating with Evernote and authorizing our app, they're sent to `/callback` (which we defined during the `/requesttoken` route):

<script src="https://gist.github.com/3996916.js?file=en_auth.rb"></script>

When the user is sent back to our callback URL, we verify that either:

1. The `oauth_verifier` parameter is set in the URL.
2. The `request_token` value is already present in the `session`. 

If one of these two conditions is true, we include the `oauth_verifier` parameter in our `session`. If neither of these conditions is true, the user is shown an error.

Next, we extract the access token (used to make API calls) from the and add it to `session`. If it's not there, an error is displayed. If it is, we send the user to the `/list` route we defined earlier. Assuming everything worked as advertised, the user will see their username, number of notes in their account and the name of each notebook in their account.

#### Templates

Our app utilizes two ERB templates: `index` and `error`:

<script src="https://gist.github.com/3997370.js?file=en_auth.rb"></script>

Clearly, this is a *very* simple template. First, we allow the user to authenticate with the Evernote Cloud API. This is displayed no matter what. If `session[:notebooks]` is defined, we can be reasonably sure that the user's data has been retrieved from the Evernote Cloud API. Then we display each piece of data.

<script src="https://gist.github.com/3997378.js?file=en_auth.rb"></script>

Even simpler than `index` is `error`, which displays the value of `@last_error` and prompts the user to reset their session and begin the process again.

## Conclusion

We made it!

If you had any problems with the above application, ensure that you're running the required versions of the various components. If you still need help, head over to the [Evernote Developer site](http://dev.evernote.com) and get in touch.