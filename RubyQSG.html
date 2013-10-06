<h1>The Evernote SDK for Ruby Quick Start Guide</h1>

<p>The purpose of this guide is describing how to download, install and configure the Evernote SDK for Ruby. If everything goes as planned, this shouldn't take more than 10–15 minutes.</p>

<p>Our application will perform the following actions:</p>

<ul>
<li>Authenticate with the Evernote Cloud API using OAuth.</li>
<li>List all of the notebooks in the authenticated user's account, their username and the total number of notes in their account.</li>
</ul>

<h2>What You'll Need</h2>

<p>Before we start working with the Evernote Cloud API, let's make sure everything we need is present and accounted for.</p>

<h3>Evernote API Key</h3>

<p>If you don't already have an Evernote Cloud API Key, you can request one on <a href="http://dev.evernote.com/support/api_key.php">the Evernote Developer site</a>. The API key is made up of two pieces: a Consumer Key and a Consumer Secret. You'll need both of these to complete the sample app below. </p>

<h3>Evernote Sandbox Account</h3>

<p><a href="http://sandbox.evernote.com">Sandbox</a> is Evernote's development server. You'll need to create an account on that server for use with the sample app below. If you don't already have a Sandbox account, you can create one <a href="https://sandbox.evernote.com/Registration.action">here</a>.</p>

<h3>Ruby</h3>

<p>The Ruby programming language runtime is installed by default on Mac OS X and most Unix-based operating systems (including Linux). This tutorial assumes you're using version 1.9.3 or higher of the Ruby runtime. To determine the version of Ruby running on your computer, issue the following command at the console:</p>

<pre><code>ruby -v
</code></pre>

<p>If your computer doesn't have Ruby installed, you can find information on how to do that on the <a href="http://www.ruby-lang.org/">Ruby language website</a>.</p>

<h3>RubyGems</h3>

<p>The Evernote SDK for Ruby is available as a gem (a package format used by the popular RubyGems package manager). You'll need to <a href="http://rubygems.org/pages/download">download and install RubyGems</a> if you haven't already, as we'll be using it to install a few packages upon which our sample app depends. Once you've installed it, issue this command in your terminal/console:</p>

<pre><code>gem --version
</code></pre>

<p>This will print the current version of RubyGems. This tutorial assumes you're using version 1.8.24 (the current version as of this writing). If the number displayed is lower, you would do well to update to the latest version by issuing the following command:</p>

<pre><code>gem update --system
</code></pre>

<p><em>(Note: updating RubyGems may require root or administrative privileges.)</em></p>

<h3>Sinatra</h3>

<p>The sample application described in this chapter uses <a href="http://sinatrarb.com">Sinatra</a>, a popular web development framework for Ruby. Some familiarity with Sinatra will make this example easier to understand, but isn't required. </p>

<p>Sinatra is available from RubyGems and can be installed using the <code>gem</code> command:</p>

<pre><code>gem install sinatra
</code></pre>

<p>Our sample app uses the current stable version of Sinatra, version 1.3.3.</p>

<h2>Installing the Evernote SDK for Ruby</h2>

<p>The Evernote SDK for Ruby can be easily installed by issuing the following command:</p>

<pre><code>gem install evernote_oauth
</code></pre>

<p>This package includes the complete Evernote SDK and some additional functionality to make it simpler to work with the OAuth authentication protocol (which is required by the Evernote Cloud API).</p>

<p>We now have all of the necessary software installed to construct our sample application. Let's do that now.</p>

<h2>The Sample App</h2>

<p><em>(You can view <a href="https://github.com/evernote/simple-api-client-example-ruby">the complete sample app on Github</a> if you have trouble following along here.)</em></p>

<p>Our sample app is comprised of two Ruby source files:</p>

<ol>
<li><code>evernote_config.rb</code>, which contains a few bits of configuration information.</li>
<li><code>en_oauth.rb</code>, the application source code.</li>
</ol>

<h3>Configuration</h3>

<p><code>evernote_config.rb</code> will look something like this:</p>

<script src="https://gist.github.com/3989818.js?file=evernote_config.rb"></script>

<p>The two <code>require</code> statements at the top are for the <a href="http://oauth.rubyforge.org/">Ruby OAuth gem</a>, followed by the <code>evernote_oauth</code> gem. This gem depends on the <code>oauth</code> gem and implements the entire Evernote Cloud API, plus additional OAuth-related functionality.</p>

<p>Below that, we have our Consumer Key and Consumer Secret values (which should be set to the corresponding parts of your Evernote Cloud API Key).</p>

<p>Finally, we have a boolean variable <code>SANDBOX</code> which controls whether our app will connect to the Sandbox development server. If false, our app would connect to the production Evernote service.</p>

<h3>Our App's Components</h3>

<p>Within <code>en_oauth.rb</code>, we have a few different pieces of our application: the <code>before</code> filter, the <code>helpers</code> functions, our <code>get</code> routes and a pair of simple ERB templates. </p>

<p>First, let's cover what I'm lovingly calling "the preamble":</p>

<script src="https://gist.github.com/4020133.js?file=en_auth.rb"></script>

<p>First, we include the Sinatra gem and enable cookie-based sessions (part of Sinatra). Second, we include the current directory in the <code>$LOAD_PATH</code> (so we can load our configuration file). Finally, we load said configuration file. Pretty straightforward.</p>

<p>Now, on with the meat of the app...</p>

<h4><code>before</code></h4>

<p>This filter runs when the app is initialized and verifies that the <code>OAUTH_CONSUMER_KEY</code> and <code>OAUTH_CONSUMER_SECRET</code> constants have been set in <code>evernote_config.rb</code>. If either constant is initialized to empty string, the error message is displayed:</p>

<script src="https://gist.github.com/3995397.js?file=en_oauth.rb"></script>

<h4><code>helpers</code></h4>

<p>A collection of plain Ruby functions that will be used in our application. Many of them simply represent variables that we've abstracted out of the routes portion of the application. As it happens, this section also contains the calls to the Evernote Cloud API. Let's quickly look at each of these:</p>

<ul>
<li><strong><code>auth_token</code></strong> stores the authentication token we'll be using to make calls against the Evernote Cloud API.</li>
<li><strong><code>client</code></strong> represents the instance of <code>EvernoteOAuth::Client</code>. It is instantiated using <code>auth_token</code> (if we have one), <code>OAUTH_CONSUMER_KEY</code>, <code>OAUTH_CONSUMER_SECRET</code> and <code>SANDBOX</code>.</li>
<li><strong><code>user_store</code></strong> and <strong><code>note_store</code></strong> are the two services of the Evernote Cloud API: the former deals with user and account information, the latter with the user's notes, notebooks, etc.</li>
<li><strong><code>en_user</code></strong> represents a single Evernote <code>User</code> instance retrieved from the Evernote Cloud API.</li>
<li><strong><code>notebooks</code></strong> contains a collection of <code>Notebook</code> objects as returned by the Evernote Cloud API when <code>NoteStore.listNotebooks()</code> is called.</li>
<li><strong><code>total_note_count</code></strong> is the only function in our app that performs logic beyond simply returning a value and deserves a little more explanation...</li>
</ul>

<script src="https://gist.github.com/3995544.js?file=en_oauth.rb"></script>

<p>We begin with <code>filter</code>, a new (empty) instance of <code>NoteFilter</code>. Since we want to query the entire account, we won't be adding any additional filtering criteria (<a href="http://dev.evernote.com/documentation/reference/NoteStore.html#Struct_NoteFilter">see the full <code>NoteFilter</code> definition here</a>).</p>

<p>Next, we call <code>findNoteCounts</code>, passing our <code>auth_token</code> and <code>filter</code> as parameters (the <code>false</code> parameter indicates that we don't want notes from the account's Trash container). <code>findNoteCounts</code> returns an instance of  <code>NoteCollectionCounts</code> — a hash of notebook GUIDs mapped to the number of notes in the corresponding notebook. Iterating over all of our notebooks, we ask <code>counts</code> (our instance of <code>NoteCollectionCounts</code>) for the number of notes in that notebook—using its GUID—and return the total of these counts. </p>

<h4><code>get</code> Routes</h4>

<p>Each instance of <code>get</code> in our app represents an HTTP request and a corresponding URL pattern. Our application has a total of seven routes. Four of them deal directly with our OAuth implementation and will be discussed in the next section. The remaining three are:</p>

<script src="https://gist.github.com/3996447.js?file=en_oauth.rb"></script>

<p>The root of our site, this route simply displays the <code>index</code> template (defined as <code>@@index</code> at the end of <code>en_auth.rb</code>) and prompts the user to begin the OAuth authentication process.</p>

<script src="https://gist.github.com/3996450.js?file=en_oauth.rb"></script>

<p>In this route, we first clear the <code>session</code> object (which is used to track the user's progress and state across a necessarily stateless web interaction), then redirect the user to <code>/</code> so they can begin the process again.</p>

<script src="https://gist.github.com/3996456.js?file=en_oauth.rb"></script>

<p>This method collects various information about the user's account (using methods defined in the <code>helpers</code> section of our app), adds them to the current <code>session</code> object and renders the <code>index</code> template. If there are any problems, the <code>rescue</code> block of our code is triggered and the <code>@last_error</code> variable is populated with the cause of the error and is sent to the <code>error</code> template (also defined at the end of <code>en_auth.rb</code>).</p>

<h4>OAuth</h4>

<p>As with most OAuth flows, our authentication takes places over a series of steps:</p>

<ol>
<li>Retrieve a request token from the Evernote Cloud API. This token is used to request an authentication token in the next step.</li>
<li>Using the request token, send the user to the Evernote site where they will authenticate with their login credentials and authorize our application to access their account.</li>
<li>The Evernote website will redirect the user back to our defined callback URL and append, among other things, the authentication token we will use when making calls against the Evernote Cloud API.</li>
</ol>

<p>This process is somewhat automated in our sample application (at least, in terms of user interaction). That is to say, as each step of the process is completed, the next step will be invoked automatically using Sinatra's <code>redirect</code> facility.</p>

<script src="https://gist.github.com/3996720.js?file=en_oauth.rb"></script>

<p>Here, we ask the Evernote Cloud API for our temporary request token. </p>

<p>To start, we take the current URL as defined by the <code>request</code> object's <code>url</code> member, remove the <code>requesttoken</code> portion and replace it with <code>callback</code> to build our callback URL. Then, we call <code>client.authentication_request_token</code> to request our token (and sending the <code>callback_url</code> variable to tell the Evernote Cloud API where to send the response. If all of this goes well, the <code>session[:request_token]</code> is populated with the token value and the user is scuttled off to <code>/authorize</code>:</p>

<script src="https://gist.github.com/3996790.js?file=en_auth.rb"></script>

<p>Once we verify that <code>session[:request_token]</code> exists, we grab the <code>authorize_url</code> from the request token and send the user there where they'll be prompted to login with their Evernote account credentials and authorize our application to access their account. If <code>session[:requesttoken]</code> is <em>not</em> set, the user will see an error and be prompted to start the process over.</p>

<p>After successfully authenticating with Evernote and authorizing our app, they're sent to <code>/callback</code> (which we defined during the <code>/requesttoken</code> route):</p>

<script src="https://gist.github.com/3996916.js?file=en_auth.rb"></script>

<p>When the user is sent back to our callback URL, we verify that either:</p>

<ol>
<li>The <code>oauth_verifier</code> parameter is set in the URL.</li>
<li>The <code>request_token</code> value is already present in the <code>session</code>. </li>
</ol>

<p>If one of these two conditions is true, we include the <code>oauth_verifier</code> parameter in our <code>session</code>. If neither of these conditions is true, the user is shown an error.</p>

<p>Next, we extract the access token (used to make API calls) from the and add it to <code>session</code>. If it's not there, an error is displayed. If it is, we send the user to the <code>/list</code> route we defined earlier. Assuming everything worked as advertised, the user will see their username, number of notes in their account and the name of each notebook in their account.</p>

<h4>Templates</h4>

<p>Our app utilizes two ERB templates: <code>index</code> and <code>error</code>:</p>

<script src="https://gist.github.com/3997370.js?file=en_auth.rb"></script>

<p>Clearly, this is a <em>very</em> simple template. First, we allow the user to authenticate with the Evernote Cloud API. This is displayed no matter what. If <code>session[:notebooks]</code> is defined, we can be reasonably sure that the user's data has been retrieved from the Evernote Cloud API. Then we display each piece of data.</p>

<script src="https://gist.github.com/3997378.js?file=en_auth.rb"></script>

<p>Even simpler than <code>index</code> is <code>error</code>, which displays the value of <code>@last_error</code> and prompts the user to reset their session and begin the process again.</p>

<h2>Conclusion</h2>

<p>We made it!</p>

<p>If you had any problems with the above application, ensure that you're running the required versions of the various components. If you still need help, head over to the <a href="http://dev.evernote.com">Evernote Developer site</a> and get in touch.</p>
