/+  *server, default-agent
/=  index
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/pottery/index
  /|  /html/
      /~  ~
  ==
/=  tile-js
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/pottery/js/tile
  /|  /js/
      /~  ~
  ==
/=  script
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/pottery/js/index
  /|  /js/
      /~  ~
  ==
/=  style
  /^  octs
  /;  as-octs:mimes:html
  /:  /===/app/pottery/css/index
  /|  /css/
      /~  ~
  ==
/=  pottery-png
  /^  (map knot @)
  /:  /===/app/pottery/img  /_  /png/
::
|%
+$  card  card:agent:gall
--
^-  agent:gall
=<
  |_  bol=bowl:gall
  +*  this       .
      pottery-core  +>
      cc         ~(. pottery-core bol)
      def        ~(. (default-agent this %|) bol)
  ::
  ++  on-init
    ^-  (quip card _this)
    =/  launcha  [%launch-action !>([%pottery / '/~pottery/js/tile.js'])]
    :_  this
    :~  [%pass / %arvo %e %connect [~ /'~pottery'] %pottery]
        [%pass /pottery %agent [our.bol %launch] %poke launcha]
    ==
  ++  on-poke
    |=  [=mark =vase]
    ^-  (quip card _this)
    ?>  (team:title our.bol src.bol)
    ?+    mark  (on-poke:def mark vase)
        %handle-http-request
      =+  !<([eyre-id=@ta =inbound-request:eyre] vase)
      :_  this
      %+  give-simple-payload:app  eyre-id
      %+  require-authorization:app  inbound-request
      poke-handle-http-request:cc
    ::
        %json
      ~&  >  %poked
      =+  !<(=json vase)
      ~&  >  json=json
      `this

    ==
  ::
  ++  on-watch
    |=  =path
    ^-  (quip card:agent:gall _this)
    ?:  ?=([%http-response *] path)
      `this
    ?:  =(/primary path)
      [[%give %fact ~ %json !>(get-data:cc)]~ this]
    ?.  =(/ path)
      (on-watch:def path)
    [[%give %fact ~ %json !>(*json)]~ this]
  ::
  ++  on-agent  on-agent:def
  ::
  ++  on-arvo
    |=  [=wire =sign-arvo]
    ^-  (quip card _this)
    ?.  ?=(%bound +<.sign-arvo)
      (on-arvo:def wire sign-arvo)
    [~ this]
  ::
  ++  on-save  on-save:def
  ++  on-load  on-load:def
  ++  on-leave  on-leave:def
  ++  on-peek   on-peek:def
  ++  on-fail   on-fail:def
  --
::
::
=,  clay
|_  bol=bowl:gall
::
++  poke-handle-http-request
  |=  =inbound-request:eyre
  ^-  simple-payload:http
  =+  url=(parse-request-line url.request.inbound-request)
  ?+  site.url  not-found:gen
      [%'~pottery' %css %index ~]  (css-response:gen style)
      [%'~pottery' %js %tile ~]    (js-response:gen tile-js)
      [%'~pottery' %js %index ~]   (js-response:gen script)
  ::
      [%'~pottery' %img @t *]
    =/  name=@t  i.t.t.site.url
    =/  img  (~(get by pottery-png) name)
    ?~  img
      not-found:gen
    (png-response:gen (as-octs:mimes:html u.img))
  ::
      [%'~pottery' *]  (html-response:gen index)
  ==
::
++  start-path  /(scot %p our.bol)/home/(scot %da now.bol)
+$  commit
  [=tako parents=(list tako) children=(list tako) wen=@da content-hash=@uvI]
++  get-data
  ^-  json
  =+  .^(desks=(set desk) %cd start-path)
  =/  heads=(list [tako desk])
    %+  turn  ~(tap in desks)
    |=  =desk
    =+  .^(=dome %cv /(scot %p our.bol)/[desk]/(scot %da now.bol))
    =/  =tako  (~(got by hit.dome) let.dome)
    [tako desk]
  =/  yakis=(set yaki)
    %-  silt
    ^-  (list yaki)
    %-  zing  
    %+  turn  heads
    |=  [=tako =desk]
    (trace-tako tako)
  =/  commits=(list commit)  (yakis-to-commits ~(tap in yakis))
  =,  enjs:format
  %:  pairs

    head+(pairs (turn heads |=([=tako =desk] (scot %uv tako)^s+desk)))
    commits+(commits-to-json commits)
    ~
  ==
::
++  yakis-to-commits
  |=  yakis=(list yaki)
  ^-  (list commit)
  %+  turn  yakis
  |=  =yaki
  :*  r.yaki  p.yaki
      =/  candidates
        %+  turn
          (skim yakis |=(can=^yaki (lien p.can |=(=tako =(r.yaki tako)))))
        |=  can=^yaki
        r.can
      ~(tap in (silt candidates))
      t.yaki
      .^(@uvI %cs (weld start-path /hash/(scot %uv r.yaki)))
  ==
::
++  trace-tako
  |=  =tako
  ~+
  ^-  (list yaki)
  =+  .^(=yaki %cs (weld start-path /yaki/(scot %uv tako)))
  :-  yaki
  (zing (turn p.yaki trace-tako))
::
++  commits-to-json
  |=  commits=(list commit)
  ^-  json
  :-  %a
  %+  turn
    %+  sort  commits
    |=  [a=commit b=commit]
    (gte wen.a wen.b)
  |=  =commit
  (commit-to-json commit)
::
++  commit-to-json
  |=  =commit
  ^-  json
  =,  enjs:format
  %:  pairs
    'commitHash'^(tako-to-json tako.commit)
    parents+a+(flop (turn parents.commit tako-to-json))
    children+a+(flop (turn children.commit tako-to-json))
    'contentHash'^(tako-to-json content-hash.commit)
    ~
  ==
::
++  tako-to-json
  |=  =tako
  ^-  json
  s+(scot %uv tako)
--
