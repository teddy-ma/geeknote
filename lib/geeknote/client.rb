module GeekNote
  class Client
    
    @@evernoteHost = "sandbox.evernote.com" #www.evernote.com for production
    @@auth_token = "S=s1:U=840c1:E=148e577e596:C=1418dc6b999:P=1cd:A=en-devtoken:V=2:H=f597a57e759dfaba5e319931fcad97a2" # my developer account auth token
    @@consumer_key = "mlc880926-4220"
    @@consumer_secret = "e95f2e2559cd8ce3"
    @@netrc_domain = "geeknote.javaer.me"

    #列出所有的笔记本
    def list_notebooks      
      client = get_client
      note_store = client.note_store
      notebooks = note_store.listNotebooks
      puts "your note books list ......"
      notebooks.each do |nb|
        puts nb.name
      end
    end

    #创建笔记
    def create_note(title, content)
      client = get_client
      note_store = client.note_store
      note = Evernote::EDAM::Type::Note.new
      note.title = title
      t = Tempfile.new("geeknote#{rand(999999)}")
      system("vim #{t.path}") #editor should be config
      content = File.open(t.path).readlines.inject
      t.unlink
      note_content = '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE en-note SYSTEM "http://xml.evernote.com/pub/enml2.dtd"><en-note>'+content+'<br/></en-note>'
      #content should be a template
      note.content = note_content
      note_store.createNote(note)
    end

    #查找笔记
    def find_note
      client = get_client
      note_store = client.note_store
      notebooks = note_store.listNotebooks
      defaultNotebook = notebooks.first #第一本笔记本就是默认笔记本......
      puts "your default notebook is #{defaultNotebook.name}"
      noteFilter = Evernote::EDAM::NoteStore::NoteFilter.new(:notebookGuid => defaultNotebook.guid)
      begin
        puts "these are notes in your default notebook ......"
        noteList = note_store.findNotes(get_token,noteFilter,0,10) #只取10本
        noteList.notes.each do |note|
          puts note.title
        end
      rescue => err
        p err
      end
    end

    #列出标签
    def list_tags
      client = get_client
      note_store = client.note_store
      tags = note_store.listTags
      puts "your tags list ......"
      tags.each do |tag|
        puts tag.name
      end
    end

    #帐号信息(用户信息)
    def who_am_i
      client = get_client
      user_store = client.user_store
      puts "hello,#{user_store.getUser.username}"  
    end

    #关于(开发者)
    def about
      client = EvernoteOAuth::Client.new(token: @@auth_token)
      user_store = client.user_store
      puts "Hi I am the developer #{user_store.getUser.username}"  
    end

    #登录
    def login
      print "What's your evernote sandbox account?"
      gets_account = gets.chomp()
      print "And the password?"
      gets_password = gets.chomp()
    
      #模拟网页端的登录
      begin
        client = get_client
        callback_url = "http://javaer.me"
        request_token = client.request_token(:oauth_callback => callback_url)
      
        agent = Mechanize.new
        page = agent.get(request_token.authorize_url)
       
        login_form = page.form('login_form')
        login_form.username = gets_account
        login_form.password = gets_password
        page = agent.submit(login_form, login_form.buttons.first)
       
        oauth_authorize_form = page.form('oauth_authorize_form')
        page = agent.submit(oauth_authorize_form, oauth_authorize_form.buttons.first)
      
        str = page.uri.to_s.split('oauth_verifier=')
        verfiy_code = str[1]
        final_token = request_token.get_access_token(:oauth_verifier => verfiy_code)
        puts final_token
        n = Netrc.read
        n[@@netrc_domain] = login_form.username, final_token.token
        n.save
        puts "awesome, you have login success"
      rescue => err
        puts "something wrong, maybe you got the wrong account or password"
      end
    end

    #登出
    def logout
      print "are you sure?(yes/no)"
      gets_answer = gets.chomp()
      if "yes" == gets_answer
        n = Netrc.read
        n.delete @@netrc_domain
        n.save
        puts "awesome, you have logout success"
      end
    end

    private

      #从配置文件中读取token
      def get_token 
        n = Netrc.read
        user, token = n[@@netrc_domain]
        return token
      end

      def get_client
        client = EvernoteOAuth::Client.new(token: get_token, consumer_key: @@consumer_key, consumer_secret: @@consumer_secret, sandbox: true)
      end

  end
end
