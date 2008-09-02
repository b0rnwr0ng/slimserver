package Slim::Control::Request;

# SqueezeCenter Copyright 2001-2007 Logitech.
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License,
# version 2.

# This class implements a generic request mechanism for SqueezeCenter.
# More documentation is provided below the table of commands & queries

=head1 NAME

Slim::Control::Request

=head1 DESCRIPTION

This class implements a generic request mechanism for SqueezeCenter.

The general mechansim is to create a Request object and execute it. There is
an option of specifying a callback function, to be called once the request is
executed. In addition, external code can be notified of command execution (see
NOTIFICATIONS below).

Function "Slim::Control::Request::executeRequest" accepts the usual parameters
of client, command array and callback params, and returns the request object.

my $request = Slim::Control::Request::executeRequest($client, ['stop']);

=cut

#####################################################################################################################################################################

=head1 COMMANDS & QUERIES LIST

 This table lists all supported commands and queries with their parameters. 

 C     P0             P1                          P2                          P3               P4       P5

=cut

#####################################################################################################################################################################

=head2 GENERAL

 N    debug           <debugflag>                 <OFF|FATAL|ERROR|WARN|INFO|DEBUG|?|>
 N    pref            <prefname>                  <prefvalue|?>
 N    version         ?
 N    stopserver

=head2 DATABASE

 N    rescan          <|playlists|?>
 N    rescanprogress  <tagged parameters>
 N    wipecache
 
 N    albums          <startindex>                <numitems>                  <tagged parameters>
 N    artists         <startindex>                <numitems>                  <tagged parameters>
 N    genres          <startindex>                <numitems>                  <tagged parameters>
 N    info            total                       genres|artists|albums|songs ?
 N    songinfo        <startindex>                <numitems>                  <tagged parameters> (DEPRECATED)
 N    titles          <startindex>                <numitems>                  <tagged parameters>
 N    years           <startindex>                <numitems>                  <tagged parameters>
 N    musicfolder     <startindex>                <numitems>                  <tagged parameters>
 
 N    playlists       <startindex>                <numitems>                  <tagged parameters>
 N    playlists       tracks                      <startindex>                <numitems>       <tagged parameters>
 N    playlists       edit                        <tagged parameters>
 N    playlists       new                         <tagged parameters>
 N    artwork         <tagged parameters>

 N    rating          <item>                      <rating>
 N    rating          <item>                      ?

=head2 PLAYERS


 Y    alarm           <tagged parameters>
 Y    button          <buttoncode>
 Y    connect         <ip|www.squeezenetwork.com|www.beta.squeezenetwork.com>
 Y    client          forget
 Y    display         <line1>                     <line2>                       <duration>
 Y    ir              <ircode>                    <time>
 Y    mixer           volume                      <0..100|-100..+100|?>
 Y    mixer           bass                        <0..100|-100..+100|?>
 Y    mixer           treble                      <0..100|-100..+100|?>
 Y    mixer           pitch                       <80..120|-100..+100|?>
 Y    mixer           muting                      <|?>
 Y    name            <newname|?>
 Y    playerpref      <prefname>                  <prefvalue|?>
 Y    power           <0|1|?|>
 Y    sleep           <0..n|?>
 Y    sync            <playerindex|playerid|-|?>
 Y    mode            ?
 Y    irenable        <0|1|?|>
 
 Y    alarms          <startindex>                <numitems>                  <tagged parameters>
 Y    signalstrength  ?
 Y    connected       ?
 Y    display         ?                           ?
 Y    displaynow      ?                           ?
 Y    displaystatus   <tagged parameters>
 Y    show
 N    player          count                       ?
 N    player          ip                          <index or ID>               ?
 N    player          id|address                  <index or ID>               ?
 N    player          name                        <index or ID>               ?
 N    player          model                       <index or ID>               ?
 N    player          isplayer                    <index or ID>               ?
 N    player          displaytype                 <index or ID>               ?
 N    players         <startindex>                <numitems>                  <tagged parameters>


=head2 PLAYLISTS

 Y    pause           <0|1|>
 Y    play
 Y    playlist        add|append                  <item> (item can be a song, playlist or directory)
 Y    playlist        addalbum                    <genre>                     <artist>         <album>  <songtitle>
 Y    playlist        addtracks                   <searchterms>    
 Y    playlist        clear
 Y    playlist        delete                      <index>
 Y    playlist        deletealbum                 <genre>                     <artist>         <album>  <songtitle>
 Y    playlist        deleteitem                  <item> (item can be a song, playlist or directory)
 Y    playlist        deletetracks                <searchterms>   
 Y    playlist        index|jump                  <index|?>
 Y    playlist        insert|insertlist           <item> (item can be a song, playlist or directory)
 Y    playlist        insertalbum                 <genre>                     <artist>         <album>  <songtitle>
 Y    playlist        inserttracks                <searchterms>    
 Y    playlist        loadalbum|playalbum         <genre>                     <artist>         <album>  <songtitle>
 Y    playlist        loadtracks                  <searchterms>    
 Y    playlist        move                        <fromindex>                 <toindex>
 Y    playlist        play|load|resume            <item> (item can be a song, playlist or directory)
 Y    playlist        playtracks                  <searchterms>    
 Y    playlist        repeat                      <0|1|2|?|>
 Y    playlist        shuffle                     <0|1|2|?|>
 Y    playlist        save                        <name>
 Y    playlist        zap                         <index>
 Y    playlistcontrol <tagged parameters>
 Y    stop
 Y    time            <0..n|-n|+n|?>
 
 Y    artist          ?
 Y    album           ?
 Y    duration        ?
 Y    genre           ?
 Y    title           ?
 Y    path            ?
 Y    current_title   ?
 Y    remote          ?
 
 Y    playlist        tracks                      ?
 
 Y    playlist        genre                       <index>                     ?
 Y    playlist        artist                      <index>                     ?
 Y    playlist        album                       <index>                     ?
 Y    playlist        title                       <index>                     ?
 Y    playlist        duration                    <index>                     ?
 Y    playlist        path                        <index>                     ?
 Y    playlist        remote                      <index>                     ?
 
 Y    playlist        name                        ?
 Y    playlist        url                         ?
 Y    playlist        modified                    ?
 Y    playlist        playlistsinfo               <tagged parameters>
 
 COMPOUND
 
 N    serverstatus    <startindex>                <numitems>                  <tagged parameters>
 Y    status          <startindex>                <numitems>                  <tagged parameters>
 
 
 DEPRECATED (BUT STILL SUPPORTED)
 Y    mode            <play|pause|stop>
 Y    gototime        <0..n|-n|+n|?>
 N    playlisttracks  <startindex>                <numitems>                  <tagged parameters>


=head2 NOTIFICATION

 The following 'terms' are used for notifications 

 Y    client          disconnect
 Y    client          new
 Y    client          reconnect
 Y    client          upgrade_firmware
 Y    playlist        load_done
 Y    playlist        newsong                     <current_title>
 Y    playlist        open                        <url>
 Y    playlist        sync
 Y    playlist        cant_open                   <url>                      <error>
 N    rescan          done
 Y    unknownir       <ircode>                    <timestamp>
 N    prefset         <namespace>                 <prefname>                  <newvalue>
 Y    alarm           sound                       <id>
 Y    alarm           end                         <id>
 Y    alarm           snooze                      <id>
 Y    alarm           snooze_end                  <id>

=head2 PLUGINS

 Plugins can call addDispatch (see below) to add their own commands to this
 table.

=cut

#####################################################################################################################################################################

=head1 REQUESTS

 Requests are object that embodies all data related to performing an action or
 a query.

=head2 ** client ID **          

   Requests store the client ID, if any, to which it applies
     my $clientid = $request->clientid();   # read
     $request->clientid($client->id());     # set

   Methods are provided for convenience using a client, in particular all 
   executeXXXX calls
     my $client = $request->client();       # read
     $request->client($client);             # set

   Some requests require a client to operate. This is encoded in the
   request for error detection. These calls are unlikely to be useful to 
   users of the class but mentioned here for completeness.
     if ($request->needClient()) { ...      # read
     $request->needClient(1);               # set

=head2 ** type **

   Requests are commands that do something or queries that change nothing but
   mainly return data. They are differentiated mainly for performance reasons,
   for example queries are NOT notified. These calls are unlikely to be useful
   to users of the class but mentioned here for completeness.
     if ($request->query()) {...            # read
     $request->query(1);                    # set

=head2 ** request name **

   For historical reasons, command names are composed of multiple terms, f.e.
   "playlist save" or "info total genres", represented as an array. This
   convention was kept, mainly because of the amount of code relying on it.
   The request name is therefore represented as an array, that you can access
   using the getRequest method
     $request->getRequest(0);               # read the first term f.e. "playlist"
     $request->getRequest(1);               # read 2nd term, f.e. "save"
     my $cnt = $request->getRequestCount(); # number of terms
     my $str = $request->getRequestString();# string of all terms, f.e. "playlist save"

   Normally, creating the request is performed through the execute calls or by
   calling new with an array that is parsed by the code here to match the
   available commands and automatically assign parameters. The following
   method is unlikely to be useful to users of this class, but is mentioned
   for completeness.
     $request->addRequest($term);           # add a term to the request

=head2 ** parameters **

   The parsing performed on the array names all parameters, positional or
   tagged. Positional parameters are assigned a name from the addDispatch table,
   and any extra parameters are added as "_pX", where X is the position in the
   array. Tagged parameters are named by their tags, obviously.
   As a consequence, users of the class only access parameter by name
     $request->getParam('_index');          # get the '_index' param
     $request->getParam('_p4');             # get the '_p4' param (auto named)
     $request->getParam('cmd');             # get a tagged param

   Here again, routines used to add parameters are normally not used
   by users of this class, but for completeness
     $request->addParamPos($value);         # adds positional parameter
     $request->addParam($key, $value);      # adds named parameter

=head2 ** results **

   Queries, but some commands as well, do add results to a request. Results
   are either single data points (f.e. how many elements where inserted) or 
   loops (i.e. data for song 1, data being a list of single data point, data for
   song 2, etc).
   Results are named like parameters. Obviously results are only available 
   once the request has been executed (without errors)
     my $data = $request->getResult('_value');
                                            # get a result

   There can be multiple loops in the results. Each loop is named and starts
   with a '@'.
     my $looped = $request->getResultLoop('@songs', 0, '_value');
                                            # get first '_value' result in
                                            # loop '@songs'


=head1 NOTIFICATIONS

 The Request mechanism can notify "subscriber" functions of successful
 command request execution (not of queries). Callback functions have a single
 parameter corresponding to the request object.
 Optionally, the subscribe routine accepts a filter, which limits calls to the
 subscriber callback to those requests matching the filter. The filter is
 in the form of an array ref containing arrays refs (one per dispatch level) 
 containing lists of desirable commands (easier to code than explain, see
 examples below).
 Note that notifications are performed asynchronously from the corresponding
 requests. Notifications are queued and performed when time allows.

=head2 Example

 Slim::Control::Request::subscribe( \&myCallbackFunction, 
                                     [['playlist']]);
 -> myCallbackFunction will be called for any command starting with 'playlist'
 in the table below ('playlist save', playlist loadtracks', etc).

 Slim::Control::Request::subscribe( \&myCallbackFunction, 
				                      [['playlist'], ['save', 'clear']]);
 -> myCallbackFunction will be called for commands "playlist save" and
 "playlist clear", but not for "playlist loadtracks".

 In both cases, myCallbackFunction must be defined as:
 sub myCallbackFunction {
      my $request = shift;

      # do something useful here
      # use the methods of $request to find all information on the
      # request.

      my $client = $request->client();

      my $cmd = $request->getRequestString();

      $log->info("myCallbackFunction called for cmd $cmd\n");
 }


=head1 WRITING COMMANDS & QUERIES, PLUGINS

=head2 This sections provides a rough guide to writing commands and queries.

 Plugins are welcomed to add their own commands to the dispatch table. The
 commands or queries are therefore automatically available in the CLI. Plugin
 authors shall document their commands and queries as they see fit. Plugins
 delivered with the server are documented in the cli API document.

=head2 Adding a command

 To add a command to the dispatch table, use the addDispatch method. If the
 method is part of SqueezeCenter itself, please add it to the init method below
 and update the comment table at the top of the document. 
 In a plugin, call the method from your initPlugin subroutine.

  Slim::Control::Request::addDispatch([<TERMS>], [<DEFINITION>]);

 <TERMS> is a list of the name of the command or query AND positional 
 parameters. (Strictly speaking, the function expects 2 array references).
 The name of the request can be one or more words, like "playlist clear" or
 "info total genres ?". They have to be array elements, so look like:

      addDispatch(['info', 'total', 'genres', '?'], ...

 The request mechanism uses the first array to match requests to definitions.
 There are 3 possibilities: '?' matches itself, but is not added as a param
 (the idea is that the result replaces it). Anything starting with '_' is a 
 parameter: something can be provided to give it a value: it is added to the 
 request as a named parameter. Anything else much match itself and is 
 considered part of the request.
 Order matter we well: first request name, then named parameters, then ?.
 
       addDispatch(['playlist', 'artist', '_index', '?'], ...

   -> ['playlist', 'artist', 'whatever', '?'] OK
   -> ['playlist', 'artist', '33',       '?'] OK
   -> ['playlist', 'artist', '?']             NOK (missing param)
   -> ['playlist', 'artist', '33']            NOK (missing ?)


 The second array <DEFINITION> contains information about the request:
  array[0]: flag indicating if the request requires a client. If enabled,
            the request will not proceed if the client is invalid or undef.
  array[1]: flag indicating if the request is a query. If enabled, the request
            is not notified.
  array[2]: flag indicating if the request has tagged parameters (in the form
            'tag:value'. If enabled the request will look for them while
            parsing the input.
  array[3]: function reference. Please refer to Commands.pm and Queries.pm for
            examples.

 For updates or new server commands, the table format below is the preferred
 choice. In a plugin, the following form may be used:

        |requires Client
        |  |is a Query
        |  |  |has Tags
        |  |  |  |Function to call
        C  Q  T  F

   Slim::Control::Request::addDispatch(['can'], 
       [0, 1, 0, \&canQuery]);

=head2 Grabbing a command

 Some plugins may require to replace or otherwise complete a built in command of
 the server (or a command added by another plugin that happened to load before).
 
 The addDispatch call will return the function pointer of any existing 
 command it replaces. There is no check on the <DEFINITION> array.
 
 So for example, a plugin could replace the "volume" command with the 
 following code example:
 
   my $original_func = addDispatch(['mixer', 'volume', '_newvalue'],
       [1, 0, 0, \&new_mixerVolumeCommand]);
   
 Please perform all relevant checks in the new function and check the 
 original code for any twists to take into account, like synced players.
 Your code should either end up calling $request->setStatusDone OR call the
 original function, maybe after some parameter doctoring.
 
 The function dynamicAutoQuery() in Queries.pm is a good example of this 
 technique.

=cut

use strict;

use Scalar::Util qw(blessed);
use Tie::IxHash;

use Slim::Control::Commands;
use Slim::Control::Queries;
use Slim::Utils::Log;
use Slim::Utils::Misc;
use Slim::Utils::Strings qw(cstring);

our %dispatchDB;                # contains a multi-level hash pointing to
                                # each command or query subroutine

our %listeners = ();            # contains the clients to the notification
                                # mechanism (internal to the server)

our %subscribers = ();          # contains the requests being subscribed to
                                # (generaly by external users/clients)
                                
our @notificationQueue;         # contains the Requests waiting to be notified

my $listenerSuperRE = qr/::/;   # regexp to screen out request which no listeners are interested in
                                # (maintained by __updateListenerSuperRE, :: = won't match)

my $alwaysUseIxHashes = 0;      # global flag which is set when we need to use tied IxHashes
                                # this is set when a cli subscription is active

our $requestTask = Slim::Utils::PerfMon->new('Request Task', [0.002, 0.005, 0.01, 0.02, 0.05, 0.1, 0.5, 1, 5]);

my $log = logger('control.command');

################################################################################
# Package methods
################################################################################
# These function are really package functions, i.e. to be called like
#  Slim::Control::Request::subscribe() ...

# adds standard commands and queries to the dispatch DB...
sub init {

	# Allow deparsing of code ref function names.
	Slim::bootstrap::tryModuleLoad('Slim::Utils::PerlRunTime');

######################################################################################################################################################################
#                                                                                                           |requires Client
#                                                                                                           |  |is a Query
#                                                                                                           |  |  |has Tags
#                                                                                                           |  |  |  |Function to call
#                     P0               P1                P2            P3             P4         P5         C  Q  T  F
######################################################################################################################################################################

	addDispatch(['abortscan'],                                                                         [0, 0, 0, \&Slim::Control::Commands::abortScanCommand]);
	addDispatch(['alarm',          '_cmd'],                                                                     [1, 0, 1, \&Slim::Control::Commands::alarmCommand]);
	addDispatch(['alarms',         '_index',         '_quantity'],                                     [1, 1, 1, \&Slim::Control::Queries::alarmsQuery]);
	addDispatch(['album',          '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['albums',         '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::albumsQuery]);
	addDispatch(['artist',         '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['artists',        '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::artistsQuery]);
	addDispatch(['button',         '_buttoncode',    '_time',      '_orFunction'],                     [1, 0, 0, \&Slim::Control::Commands::buttonCommand]);
	addDispatch(['client',         'forget'],                                                          [1, 0, 0, \&Slim::Control::Commands::clientForgetCommand]);
	addDispatch(['connect',        '_where'],                                                          [1, 0, 0, \&Slim::Control::Commands::clientConnectCommand]);
	addDispatch(['connected',      '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::connectedQuery]);
	addDispatch(['contextmenu',    '_index',         '_quantity'],                                     [1, 1, 1, \&Slim::Control::Queries::contextMenuQuery]);
	addDispatch(['current_title',  '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['debug',          '_debugflag',     '?'],                                             [0, 1, 0, \&Slim::Control::Queries::debugQuery]);
	addDispatch(['debug',          '_debugflag',     '_newvalue'],                                     [0, 0, 0, \&Slim::Control::Commands::debugCommand]);
	addDispatch(['disconnect',     '_playerid',      '_from'],                                         [0, 0, 0, \&Slim::Control::Commands::disconnectCommand]);
	addDispatch(['display',        '?',              '?'],                                             [1, 1, 0, \&Slim::Control::Queries::displayQuery]);
	addDispatch(['display',        '_line1',         '_line2',     '_duration'],                       [1, 0, 0, \&Slim::Control::Commands::displayCommand]);
	addDispatch(['displaynow',     '?',              '?'],                                             [1, 1, 0, \&Slim::Control::Queries::displaynowQuery]);
	addDispatch(['displaystatus'],                                                                     [1, 1, 1, \&Slim::Control::Queries::displaystatusQuery]);
	addDispatch(['duration',       '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['readdirectory',  '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::readDirectoryQuery]);
	addDispatch(['genre',          '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['genres',         '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::genresQuery]);
	addDispatch(['getstring',      '_tokens'],                                                         [0, 1, 0, \&Slim::Control::Queries::getStringQuery]);
	addDispatch(['info',           'total',          'albums',     '?'],                               [0, 1, 0, \&Slim::Control::Queries::infoTotalQuery]);
	addDispatch(['info',           'total',          'artists',    '?'],                               [0, 1, 0, \&Slim::Control::Queries::infoTotalQuery]);
	addDispatch(['info',           'total',          'genres',     '?'],                               [0, 1, 0, \&Slim::Control::Queries::infoTotalQuery]);
	addDispatch(['info',           'total',          'songs',      '?'],                               [0, 1, 0, \&Slim::Control::Queries::infoTotalQuery]);
	addDispatch(['ir',             '_ircode',        '_time'],                                         [1, 0, 0, \&Slim::Control::Commands::irCommand]);
	addDispatch(['irenable',       '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::irenableQuery]);
	addDispatch(['irenable',       '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::irenableCommand]);
	addDispatch(['linesperscreen', '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::linesperscreenQuery]);
	addDispatch(['mixer',          'bass',           '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'bass',           '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mixer',          'muting',         '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'muting',         '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mixer',          'stereoxl',       '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'stereoxl',       '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mixer',          'pitch',          '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'pitch',          '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mixer',          'treble',         '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'treble',         '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mixer',          'volume',         '?'],                                             [1, 1, 0, \&Slim::Control::Queries::mixerQuery]);
	addDispatch(['mixer',          'volume',         '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::mixerCommand]);
	addDispatch(['mode',           '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::modeQuery]);
	addDispatch(['musicfolder',    '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::musicfolderQuery]);
	addDispatch(['name',           '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::nameCommand]);
	addDispatch(['name',           '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::nameQuery]);
	addDispatch(['path',           '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['pause',          '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	addDispatch(['play'],                                                                              [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	addDispatch(['player',         'address',        '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'count',          '?'],                                             [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'displaytype',    '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'id',             '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'uuid',           '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'ip',             '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'model',          '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'isplayer',       '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'name',           '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['player',         'canpoweroff',    '_IDorIndex', '?'],                               [0, 1, 0, \&Slim::Control::Queries::playerXQuery]);
	addDispatch(['playerpref',     '_prefname',      '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playerprefQuery]);
	addDispatch(['playerpref',     'validate',       '_prefname',  '_newvalue'],                       [1, 1, 0, \&Slim::Control::Queries::prefValidateQuery]);
	addDispatch(['playerpref',     '_prefname',      '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::playerprefCommand]);
	addDispatch(['players',        '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::playersQuery]);
	addDispatch(['playlist',       'add',            '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'addalbum',       '_genre',     '_artist',     '_album', '_title'], [1, 0, 0, \&Slim::Control::Commands::playlistXalbumCommand]);
	addDispatch(['playlist',       'addtracks',      '_what',      '_listref'],                        [1, 0, 0, \&Slim::Control::Commands::playlistXtracksCommand]);
	addDispatch(['playlist',       'album',          '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'append',         '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'artist',         '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'clear'],                                                           [1, 0, 0, \&Slim::Control::Commands::playlistClearCommand]);
	addDispatch(['playlist',       'delete',         '_index'],                                        [1, 0, 0, \&Slim::Control::Commands::playlistDeleteCommand]);
	addDispatch(['playlist',       'deletealbum',    '_genre',     '_artist',     '_album', '_title'], [1, 0, 0, \&Slim::Control::Commands::playlistXalbumCommand]);
	addDispatch(['playlist',       'deleteitem',     '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistDeleteitemCommand]);
	addDispatch(['playlist',       'deletetracks',   '_what',      '_listref'],                        [1, 0, 0, \&Slim::Control::Commands::playlistXtracksCommand]);
	addDispatch(['playlist',       'duration',       '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'genre',          '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'index',          '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'index',          '_index',     '_noplay',     '_seekdata'],        [1, 0, 0, \&Slim::Control::Commands::playlistJumpCommand]);
	addDispatch(['playlist',       'insert',         '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'insertlist',     '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'insertalbum',    '_genre',     '_artist',     '_album', '_title'], [1, 0, 0, \&Slim::Control::Commands::playlistXalbumCommand]);
	addDispatch(['playlist',       'inserttracks',   '_what',      '_listref'],                        [1, 0, 0, \&Slim::Control::Commands::playlistXtracksCommand]);
	addDispatch(['playlist',       'jump',           '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'jump',           '_index',     '_noplay',     '_seekdata'],        [1, 0, 0, \&Slim::Control::Commands::playlistJumpCommand]);
	addDispatch(['playlist',       'load',           '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'loadalbum',      '_genre',     '_artist',     '_album', '_title'], [1, 0, 0, \&Slim::Control::Commands::playlistXalbumCommand]);
	addDispatch(['playlist',       'loadtracks',     '_what',      '_listref'],                        [1, 0, 0, \&Slim::Control::Commands::playlistXtracksCommand]);
	addDispatch(['playlist',       'modified',       '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'move',           '_fromindex', '_toindex'],                        [1, 0, 0, \&Slim::Control::Commands::playlistMoveCommand]);
	addDispatch(['playlist',       'name',           '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'path',           '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'play',           '_item',      '_title'],                          [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'playalbum',      '_genre',     '_artist',     '_album', '_title'], [1, 0, 0, \&Slim::Control::Commands::playlistXalbumCommand]);
	addDispatch(['playlist',       'playlistsinfo'],                                                   [1, 1, 1, \&Slim::Control::Queries::playlistPlaylistsinfoQuery]);
	addDispatch(['playlist',       'playtracks',     '_what',      '_listref'],                        [1, 0, 0, \&Slim::Control::Commands::playlistXtracksCommand]);
	addDispatch(['playlist',       'remote',         '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'repeat',         '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'repeat',         '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::playlistRepeatCommand]);
	addDispatch(['playlist',       'resume',         '_item'],                                         [1, 0, 0, \&Slim::Control::Commands::playlistXitemCommand]);
	addDispatch(['playlist',       'save',           '_title'],                                        [1, 0, 0, \&Slim::Control::Commands::playlistSaveCommand]);
	addDispatch(['playlist',       'shuffle',        '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'shuffle',        '_newvalue'],                                     [1, 0, 0, \&Slim::Control::Commands::playlistShuffleCommand]);
	addDispatch(['playlist',       'title',          '_index',     '?'],                               [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'tracks',         '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'url',            '?'],                                             [1, 1, 0, \&Slim::Control::Queries::playlistXQuery]);
	addDispatch(['playlist',       'zap',            '_index'],                                        [1, 0, 0, \&Slim::Control::Commands::playlistZapCommand]);
	addDispatch(['playlistcontrol'],                                                                   [1, 0, 1, \&Slim::Control::Commands::playlistcontrolCommand]);
	addDispatch(['playlists',      '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::playlistsQuery]);
	addDispatch(['playlists',      'edit'],                                                            [0, 0, 1, \&Slim::Control::Commands::playlistsEditCommand]);
	addDispatch(['playlists',      'delete'],                                                          [0, 0, 1, \&Slim::Control::Commands::playlistsDeleteCommand]);
	addDispatch(['playlists',      'new'],                                                             [0, 0, 1, \&Slim::Control::Commands::playlistsNewCommand]);
	addDispatch(['playlists',      'rename'],                                                          [0, 0, 1, \&Slim::Control::Commands::playlistsRenameCommand]);
	addDispatch(['playlists',      'tracks',         '_index',     '_quantity'],                       [0, 1, 1, \&Slim::Control::Queries::playlistsTracksQuery]);
	addDispatch(['power',          '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::powerQuery]);
	addDispatch(['power',          '_newvalue',      '_noplay'],                                       [1, 0, 0, \&Slim::Control::Commands::powerCommand]);
	addDispatch(['pref',           '_prefname',      '?'],                                             [0, 1, 0, \&Slim::Control::Queries::prefQuery]);
	addDispatch(['pref',           'validate',       '_prefname',  '_newvalue'],                       [0, 1, 0, \&Slim::Control::Queries::prefValidateQuery]);
	addDispatch(['pref',           '_prefname',      '_newvalue'],                                     [0, 0, 0, \&Slim::Control::Commands::prefCommand]);
	addDispatch(['remote',         '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['rescan',         '?'],                                                               [0, 1, 0, \&Slim::Control::Queries::rescanQuery]);
	addDispatch(['rescan',         '_playlists'],                                                      [0, 0, 0, \&Slim::Control::Commands::rescanCommand]);
	addDispatch(['rescanprogress'],                                                                    [0, 1, 1, \&Slim::Control::Queries::rescanprogressQuery]);
	addDispatch(['search',         '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::searchQuery]);
	addDispatch(['serverstatus',   '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::serverstatusQuery]);
	addDispatch(['show'],                                                                              [1, 0, 1, \&Slim::Control::Commands::showCommand]);
	addDispatch(['signalstrength', '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::signalstrengthQuery]);
	addDispatch(['sleep',          '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::sleepQuery]);
	addDispatch(['sleep',          '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::sleepCommand]);
	# XXX: songinfo is deprecated, use trackinfo instead
	addDispatch(['songinfo',       '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::songinfoQuery]);
	addDispatch(['songs',          '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::titlesQuery]);
	addDispatch(['status',         '_index',         '_quantity'],                                     [1, 1, 1, \&Slim::Control::Queries::statusQuery]);
	addDispatch(['stop'],                                                                              [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	addDispatch(['stopserver'],                                                                        [0, 0, 0, \&main::stopServer]);
	addDispatch(['sync',           '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::syncQuery]);
	addDispatch(['sync',           '_indexid-'],                                                       [1, 0, 0, \&Slim::Control::Commands::syncCommand]);
	addDispatch(['time',           '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::timeQuery]);
	addDispatch(['time',           '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::timeCommand]);
	addDispatch(['title',          '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::cursonginfoQuery]);
	addDispatch(['titles',         '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::titlesQuery]);
	addDispatch(['tracks',         '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::titlesQuery]);
	addDispatch(['version',        '?'],                                                               [0, 1, 0, \&Slim::Control::Queries::versionQuery]);
	addDispatch(['wipecache'],                                                                         [0, 0, 0, \&Slim::Control::Commands::wipecacheCommand]);
	addDispatch(['years',          '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::yearsQuery]);
	addDispatch(['artwork',        '_artworkid'],                                                      [0, 0, 0, \&Slim::Control::Queries::showArtwork]);
	addDispatch(['rating',         '_item',          '?'],                                             [0, 1, 0, \&Slim::Control::Commands::ratingCommand]);
	addDispatch(['rating',         '_item',          '_rating'],                                       [0, 0, 0, \&Slim::Control::Commands::ratingCommand]);

# NOTIFICATIONS
	addDispatch(['client',         'disconnect'],                                                      [1, 0, 0, undef]);
	addDispatch(['client',         'new'],                                                             [1, 0, 0, undef]);
	addDispatch(['client',         'reconnect'],                                                       [1, 0, 0, undef]);
	addDispatch(['client',         'upgrade_firmware'],                                                [1, 0, 0, undef]);
	addDispatch(['playlist',       'load_done'],                                                       [1, 0, 0, undef]);
	addDispatch(['playlist',       'newsong'],                                                         [1, 0, 0, undef]);
	addDispatch(['playlist',       'open',           '_path'],                                         [1, 0, 0, undef]);
	addDispatch(['playlist',       'sync'],                                                            [1, 0, 0, undef]);
	addDispatch(['playlist',       'cant_open',      '_url',         '_error'],                        [1, 0, 0, undef]);
	addDispatch(['rescan',         'done'],                                                            [0, 0, 0, undef]);
	addDispatch(['unknownir',      '_ircode',        '_time'],                                         [1, 0, 0, undef]);
	addDispatch(['prefset',        '_namespace',     '_prefname',  '_newvalue'],                       [0, 0, 1, undef]);
	addDispatch(['displaynotify',  '_type',          '_parts'],                                        [1, 0, 0, undef]);
	addDispatch(['alarm',          'sound',          '_id'],                                           [1, 0, 0, undef]);
	addDispatch(['alarm',          'end',            '_id'],                                           [1, 0, 0, undef]);
	addDispatch(['alarm',          'snooze',         '_id'],                                           [1, 0, 0, undef]);
	addDispatch(['alarm',          'snooze_end',     '_id'],                                           [1, 0, 0, undef]);

# DEPRECATED
	addDispatch(['mode',           'pause'],                                                           [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	addDispatch(['mode',           'play'],                                                            [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	addDispatch(['mode',           'stop'],                                                            [1, 0, 0, \&Slim::Control::Commands::playcontrolCommand]);
	# use commands "pause", "play" and "stop"

	addDispatch(['gototime',       '?'],                                                               [1, 1, 0, \&Slim::Control::Queries::timeQuery]);
	addDispatch(['gototime',       '_newvalue'],                                                       [1, 0, 0, \&Slim::Control::Commands::timeCommand]);
	# use command "time"

	addDispatch(['playlisttracks', '_index',         '_quantity'],                                     [0, 1, 1, \&Slim::Control::Queries::playlistsTracksQuery]);
	# use query "playlists tracks"
	
######################################################################################################################################################################

	# No web code on SN
	return if main::SLIM_SERVICE;

	# Normal SqueezeCenter commands can be accessed with URLs like
	#   http://localhost:9000/status.html?p0=pause&player=00%3A00%3A00%3A00%3A00%3A00
	# Use the protectCommand() API to prevent CSRF attacks on commands -- including commands
	# not intended for use via the web interface!
	#
	# protect some commands regardless of args passed to them
	Slim::Web::HTTP::protectCommand([qw|alarm alarms button client debug display displaynow ir pause play playlist 
					playlistcontrol playlists stop stopserver wipecache prefset mode
					power rescan sleep sync time gototime
					mixer playerpref pref|]);
	# protect changing setting for command + 1-arg ("?" query always allowed -- except "?" is "%3F" once escaped)
	#Slim::Web::HTTP::protectCommand(['power', 'rescan', 'sleep', 'sync', 'time', 'gototime'],'[^\?].*');	
	# protect changing setting for command + 2 args, 2nd as new value ("?" query always allowed)
	#Slim::Web::HTTP::protectCommand(['mixer', 'playerpref', 'pref'],'.*','[^\?].*');	# protect changing volume ("?" query always allowed)

}

# add an entry to the dispatch DB
sub addDispatch {
	my $arrayCmdRef  = shift; # the array containing the command or query
	my $arrayDataRef = shift; # the array containing the function to call

	# parse the first array in parameter to create a multi level hash providing
	# fast access to 2nd array data, i.e. (the example is incomplete!)
	# { 
	#  'rescan' => {
	#               '?'          => 2nd array associated with ['rescan', '?']
	#               '_playlists' => 2nd array associated with ['rescan', '_playlists']
	#              },
	#  'info'   => {
	#               'total'      => {
	#                                'albums'  => 2nd array associated with ['info', 'total', albums']
	# ...
	#
	# this is used by init() above to add the standard commands and queries to the 
	# table and by the plugin glue code to add plugin-specific and plugin-defined
	# commands and queries to the system.
	# Note that for the moment, there is no identified need to ever REMOVE commands
	# from the dispatch table (and consequently no defined function for that).

	my $DBp     = \%dispatchDB;	    # pointer to the current table level
	my $CRindex = 0;                # current index into $arrayCmdRef
	my $done    = 0;                # are we done
	my $oldDR;                      # if we replace, what did we?

	while (!$done) {
	
		# check if we have a subsequent verb in the command
		my $haveNextLevel = defined $arrayCmdRef->[$CRindex + 1];
		
		# get the verb at the current level of the command
		my $curVerb       = $arrayCmdRef->[$CRindex];
	
		# if the verb is undefined at the current level
		if (!defined $DBp->{$curVerb}) {
		
			# if we have a next verb, prepare a hash for it
			if ($haveNextLevel) {
			
				$DBp->{$curVerb} = {};
			
			# else store the 2nd array and we're done
			} else {
			
				$DBp->{$curVerb} = $arrayDataRef;
				$done = 1;
			}
		}
		
		# if the verb defined at the current level points to an array
		elsif (ref $DBp->{$curVerb} eq 'ARRAY') {
		
			# if we have more terms, move the array to the next level using
			# an empty verb
			# (note: at the time of writing these lines, this never occurs with
			# the commands as defined now)
			if ($haveNextLevel) {
			
				$DBp->{$curVerb} = {'', $DBp->{$curVerb}};
			
			# if we're out of terms, something is maybe wrong as we're adding 
			# twice the same command. In Perl hash fashion, replace silently with
			# the new value and we're done
			} else {
			
				$oldDR = $DBp->{$curVerb};
				$DBp->{$curVerb} = $arrayDataRef;
				$done = 1;
			}
		}
		
		# go to next level if not done...
		if (!$done) {
		
			$DBp = \%{$DBp->{$curVerb}};
			$CRindex++;
		}
	}
	
	# return replaced funcptr, if any
	if (defined $oldDR) {
		return $oldDR->[3];
	}
}

# add a subscriber to be notified of requests
sub subscribe {
	my $subscriberFuncRef = shift || return;
	my $requestsRef = shift;
	my $client = shift;
	
	if ( blessed($client) ) {
		$listeners{ $client->id . $subscriberFuncRef } = [ __requestRE($requestsRef), $subscriberFuncRef, $requestsRef, $client->id ];
	}
	else {
		$listeners{$subscriberFuncRef} = [ __requestRE($requestsRef), $subscriberFuncRef, $requestsRef ];
	}
	
	# rebuild the super regexp for the current list of listeners
	__updateListenerSuperRE();

	if ( $log->is_info ) {
		$log->info(sprintf(
			"Request from: %s - (%d listeners)\n",
			Slim::Utils::PerlRunTime::realNameForCodeRef($subscriberFuncRef),
			scalar(keys %listeners)
		));
	}
}

# remove a subscriber
sub unsubscribe {
	my $subscriberFuncRef = shift;
	my $client = shift;
	
	if ( blessed($client) ) {
		delete $listeners{ $client->id . $subscriberFuncRef };
	}
	else {
		delete $listeners{$subscriberFuncRef};
	}

	# rebuild the super regexp for the current list of listeners
	__updateListenerSuperRE();

	if ( $log->is_info ) {
		$log->info(sprintf(
			"Request from: %s - (%d listeners)\n",
			Slim::Utils::PerlRunTime::realNameForCodeRef($subscriberFuncRef),
			scalar(keys %listeners)
		));
	}
}

# notify listeners from an array, useful for notifying w/o execution
# (requests must, however, be defined in the dispatch table)
sub notifyFromArray {
	my $client         = shift;     # client, if any, to which the query applies
	my $requestLineRef = shift;     # reference to an array containing the query verbs

	if ( $log->is_info ) {
		$log->info(sprintf("(%s)", join(" ", @{$requestLineRef})));
	}

	my $request = Slim::Control::Request->new(
		(blessed($client) ? $client->id() : undef), 
		$requestLineRef,
		undef,
		1, # force use of tied ixhash to maintain ordering of the array
	);
	
	push @notificationQueue, $request;
}

# sends notifications for first entry in queue - called once per idle loop
sub checkNotifications {
	
	return 0 if (!scalar @notificationQueue);

	# notify first entry on queue
	my $request = shift @notificationQueue;

	$request->notify();

	return 1;
}

# convenient function to execute a request from an array, with optional
# callback parameters. Returns the Request object.
sub executeRequest {
	my($client, $parrayref, $callbackf, $callbackargs) = @_;

	# create a request from the array
	my $request = Slim::Control::Request->new( 
		(blessed($client) ? $client->id() : undef), 
		$parrayref
	);

	if (defined $request && $request->isStatusDispatchable()) {
		
		# add callback params
		$request->callbackParameters($callbackf, $callbackargs);
		
		$request->execute();
	}

	return $request;
}

=head2 unregisterAutoExecute ( $connectionID )

Removes all subscriptions for this $connectionID. Returns 1 if there were any, else 0.

=cut
sub unregisterAutoExecute{
	my $connectionID = shift;
	
	if ($subscribers{$connectionID}) {
	
		# kill any timers
		for my $name (keys %{$subscribers{$connectionID}}) {
			for my $clientid (keys %{$subscribers{$connectionID}{$name}}) {
				
				my $request = delete $subscribers{$connectionID}{$name}{$clientid};
				
				if (my $cleanup = $request->autoExecuteCleanup()) {
					eval { &{$cleanup}($request, $connectionID) };
				}

				Slim::Utils::Timers::killTimers($request, \&__autoexecute);
			}
		}
		
		# delete everything linked to connection
		delete $subscribers{$connectionID};
		
		return 1;
	}
	return 0;
}

=head2 hasSubscribers ( $name, $clientid )

Returns true if there are subscribers for $name/$clientid on any connection

=cut
sub hasSubscribers {
	my $name     = shift;
	my $clientid = shift;

	for my $connectionID (keys %subscribers) {
		return 1 if $subscribers{$connectionID}{$name} && $subscribers{$connectionID}{$name}{$clientid};
	}

	return 0;
}

=head2 alwaysOrder ( $val )

Set the flag to always order elements stored in request objects.  This forces the use of tied IxHashes
for all requests rather than just those requests which ask for it in Slim::Controll::Request->new()

It is required if renderAsArray is to be called on the request and so is set by the cli handler whenever
there are cli subscriptions active.

=cut
sub alwaysOrder {
	$alwaysUseIxHashes = shift;
}

################################################################################
# Constructors
################################################################################

=head2 new ( clientid, requestLineRef, paramsRef )

Creates a new Request object. All parameters are optional. clientid is the
client ID the request applies to. requestLineRef is a reference to an array
containing the request terms (f.e. ['pause']). paramsRef is a reference to
a hash containing the request parameters (tags in CLI lingo, f.e. {sort=>albums}).

requestLinRef is parsed to match an entry in the dispatch table, and parameters
found there are added to the params. It best to use requestLineRef for all items
defined in the dispatch table and paramsRef only for tags.


=cut
sub new {
	my $class          = shift;    # class to construct
	my $clientid       = shift;    # clientid, if any, to which the request applies
	my $requestLineRef = shift;    # reference to an array containing the 
                                   # request verbs
	my $paramsRef      = shift;    # reference to a hash containing the params
	my $useIxHashes    = shift;    # request requires param ordering to be maintained (cli)

	$useIxHashes ||= $alwaysUseIxHashes; # if a cli subscription exists then always use IxHashes

	if (!defined $paramsRef) {
		my %paramsHash;
		tie %paramsHash, "Tie::IxHash" if $useIxHashes;
		$paramsRef = \%paramsHash;
	}

	my %resultHash;
	tie %resultHash, "Tie::IxHash" if $useIxHashes;
	
	my $self = {
		'_request'           => [],
		'_requeststr'        => '',
		'_isQuery'           => 0,
		'_clientid'          => $clientid,
		'_needClient'        => 0,
		'_params'            => $paramsRef,
		'_curparam'          => 0,
		'_status'            => 0,
		'_results'           => \%resultHash,
		'_func'              => undef,
		'_cb_enable'         => 1,
		'_cb_func'           => undef,
		'_cb_args'           => undef,
		'_source'            => undef,
		'_connectionid'      => undef,
		'_ae_callback'       => undef,
		'_ae_filter'         => undef,
		'_ae_cleanup'        => undef,
		'_private'           => undef,
		'_useixhash'         => $useIxHashes,
	};

	bless $self, $class;
	
	# parse $requestLineRef to finish create the Request
	$self->__parse($requestLineRef) if defined $requestLineRef;
	
	$self->validate();
	
	return $self;
}

# makes a request out of another one, discarding results and callback data.
# except for '_private' which we don't know about, all data is 
# duplicated
sub virginCopy {
	my $self = shift;
	
	my $copy = Slim::Control::Request->new($self->clientid());
	
	# fill in the scalars
	$copy->{'_isQuery'} = $self->{'_isQuery'};
	$copy->{'_needClient'} = $self->{'_needClient'};
	$copy->{'_func'} = \&{$self->{'_func'}};
	$copy->{'_source'} = $self->{'_source'};
	$copy->{'_private'} = $self->{'_private'};
	$copy->{'_connectionid'} = $self->{'_connectionid'};
	$copy->{'_ae_callback'} = $self->{'_ae_callback'};
	$copy->{'_ae_filter'} = $self->{'_ae_filter'};
	$copy->{'_ae_cleanup'} = $self->{'_ae_cleanup'};
	$copy->{'_curparam'} = $self->{'_curparam'};
	$copy->{'_requeststr'} = $self->{'_requeststr'};
	$copy->{'_useixhash'} = $self->{'_useixhash'};

	# duplicate the arrays and hashes
	my @request = @{$self->{'_request'}};
	$copy->{'_request'} = \@request;

	$copy->{'_params'} = $self->getParamsCopy();
	
	$self->validate();
	
	return $copy;
}
	

################################################################################
# Read/Write basic query attributes
################################################################################

# sets/returns the client (we store the id only)
sub client {
	my $self = shift;
	my $client = shift;
	
	if (defined $client) {
		$self->{'_clientid'} = (blessed($client) ? $client->id() : undef);
		$self->validate();
	}
	
	return Slim::Player::Client::getClient($self->{'_clientid'});
}

# sets/returns the client ID
sub clientid {
	my $self = shift;
	my $clientid = shift;
	
	if (defined $clientid) {
		$self->{'_clientid'} = $clientid;
		$self->validate();
	}
	
	return $self->{'_clientid'};
}

# sets/returns the need client state
sub needClient {
	my $self = shift;
	my $needClient = shift;
	
	if (defined $needClient) {
		$self->{'_needClient'} = $needClient;
		$self->validate();
	}

	return $self->{'_needClient'};
}

# sets/returns the query state
sub query {
	my $self = shift;
	my $isQuery = shift;
	
	$self->{'_isQuery'} = $isQuery if defined $isQuery;
	
	return $self->{'_isQuery'};
}

# sets/returns the function that executes the request
sub function {
	my $self = shift;
	my $newvalue = shift;
	
	if (defined $newvalue) {
		$self->{'_func'} = $newvalue;
		$self->validate();
	}
	
	return $self->{'_func'};
}

# sets/returns the callback enabled state
sub callbackEnabled {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_cb_enable'} = $newvalue if defined $newvalue;
	
	return $self->{'_cb_enable'};
}

# sets/returns the callback function
sub callbackFunction {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_cb_func'} = $newvalue if defined $newvalue;
	
	return $self->{'_cb_func'};
}

# sets/returns the callback arguments
sub callbackArguments {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_cb_args'} = $newvalue if defined $newvalue;
	
	return $self->{'_cb_args'};
}

# sets/returns the request source
sub source {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_source'} = $newvalue if defined $newvalue;
	
	return $self->{'_source'};
}

# sets/returns the source connectionid
sub connectionID {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_connectionid'} = $newvalue if defined $newvalue;
	
	return $self->{'_connectionid'};
}

# sets/returns the source subscribe callback
sub autoExecuteCallback {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_ae_callback'} = $newvalue if defined $newvalue;
	
	return $self->{'_ae_callback'};
}

# sets/returns the cleanup function for when autoexecute is cleared
sub autoExecuteCleanup {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_ae_cleanup'} = $newvalue if defined $newvalue;
	
	return $self->{'_ae_cleanup'};
}

# remove the autoExecuteCallback for this request
sub removeAutoExecuteCallback {
	my $self = shift;
	
	$self->{'_ae_callback'} = undef;
	
	my $cnxid       = $self->connectionID();
	my $name        = $self->getRequestString();
	my $clientid    = $self->clientid() || 'global';
	my $cleanup     = $self->autoExecuteCleanup();
	my $request2del = $subscribers{$cnxid}{$name}{$clientid};
	
	$log->debug("removeAutoExecuteCallback: deleting $cnxid - $name - $clientid");

	delete $subscribers{$cnxid}{$name}{$clientid};
	
	if ($cleanup) {
		eval { &{$cleanup}($self, $cnxid) };
	}
	
	# there should not be any of those, but just to be sure
	Slim::Utils::Timers::killTimers( $self, \&__autoexecute );
	Slim::Utils::Timers::killTimers( $request2del, \&__autoexecute );
	
	return 1;
}

# sets/returns the source subscribe callback
sub autoExecuteFilter {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_ae_filter'} = $newvalue if defined $newvalue && ref($newvalue) eq 'CODE';
	
	return $self->{'_ae_filter'};
}


# sets/returns the source private data
sub privateData {
	my $self = shift;
	my $newvalue = shift;
	
	$self->{'_private'} = $newvalue if defined $newvalue;
	
	return $self->{'_private'};
}


################################################################################
# Read/Write status
################################################################################
# useful hash for debugging and as a reminder when writing new status methods
my %statusMap = (
	  0 => 'New',
	  1 => 'Dispatchable',
	  2 => 'Dispatched',
	  3 => 'Processing',
	 10 => 'Done',
#	 11 => 'Callback done',
	101 => 'Bad dispatch!',
	102 => 'Bad params!',
	103 => 'Missing client!',
	104 => 'Unknown in dispatch table',
	105 => 'Bad SqueezeCenter config',
);

# validate the Request, make sure we are dispatchable
sub validate {
	my $self = shift;

	if (ref($self->{'_func'}) ne 'CODE') {

		$self->{'_status'}   = 104;

	} elsif ($self->{'_needClient'} && !defined Slim::Player::Client::getClient($self->{'_clientid'})){

		$self->{'_status'}   = 103;
		$self->{'_clientid'} = undef;

	} else {

		$self->{'_status'}   = 1;
	}
}

sub isStatusNew {
	return ($_[0]->{'_status'} == 0);
}

sub setStatusDispatchable {
	$_[0]->{'_status'} = 1;
}

sub isStatusDispatchable {
	return ($_[0]->{'_status'} == 1);
}

sub setStatusDispatched {
	$_[0]->{'_status'} = 2;
}

sub isStatusDispatched {
	return ($_[0]->{'_status'} == 2);
}

sub wasStatusDispatched {
	return ($_[0]->{'_status'} > 1);
}

sub setStatusProcessing {
	$_[0]->{'_status'} = 3;
}

sub isStatusProcessing {
	return ($_[0]->{'_status'} == 3);
}

sub setStatusDone {
	# if we are in processing state, we need to call executeDone AFTER setting
	# the status to Done...
	my $callDone = ($_[0]->{'_status'} == 3);
	$_[0]->{'_status'} = 10;
	$_[0]->executeDone() if $callDone;
}

sub isStatusDone {
	return ($_[0]->{'_status'} == 10);
}

sub isStatusError {
	return ($_[0]->{'_status'} > 100);
}

sub setStatusBadDispatch {
	$_[0]->{'_status'} = 101;
}

sub isStatusBadDispatch {
	return ($_[0]->{'_status'} == 101);
}

sub setStatusBadParams {
	$_[0]->{'_status'} = 102;
}

sub isStatusBadParams {
	return ($_[0]->{'_status'} == 102);
}

sub setStatusNeedsClient {
	$_[0]->{'_status'} = 103;
}

sub isStatusNeedsClient {
	return ($_[0]->{'_status'} == 103);
}

sub setStatusNotDispatchable {
	$_[0]->{'_status'} = 104;
}

sub isStatusNotDispatchable {
	return ($_[0]->{'_status'} == 104);
}

sub setStatusBadConfig {
	$_[0]->{'_status'} = 105;
}

sub isStatusBadConfig {
	return ($_[0]->{'_status'} == 105);
}

sub getStatusText {
	return ($statusMap{$_[0]->{'_status'}});
}
################################################################################
# Request mgmt
################################################################################

# returns the request name. Read-only
sub getRequestString {
	my $self = shift;
	
	return join " ", @{$self->{_request}};
}

# add a request value to the request array
sub addRequest {
	my $self = shift;
	my $text = shift;

	push @{$self->{'_request'}}, $text;
	++$self->{'_curparam'};
}

sub getRequest {
	my $self = shift;
	my $idx = shift;
	
	return $self->{'_request'}->[$idx];
}

sub getRequestCount {
	my $self = shift;
	my $idx = shift;
	
	return scalar @{$self->{'_request'}};
}

################################################################################
# Param mgmt
################################################################################

# add a parameter
sub addParam {
	my $self = shift;
	my $key = shift;
	my $val = shift;

	${$self->{'_params'}}{$key} = $val;
	++$self->{'_curparam'};
}

# add a nameless parameter
sub addParamPos {
	my $self = shift;
	my $val = shift;
	
	${$self->{'_params'}}{ "_p" . $self->{'_curparam'}++ } = $val;
}

# get a parameter by name
sub getParam {
	return $_[0]->{'_params'}->{ $_[1] };
}

# delete a parameter by name
sub deleteParam {
	my $self = shift;
	my $key = shift || return;
	
	delete ${$self->{'_params'}}{$key};
}

# returns a copy of all parameters
sub getParamsCopy {
	my $self = shift;
	
	my %paramHash;

	tie %paramHash, 'Tie::IxHash' if $self->{'_useixhash'};
	
	while (my ($key, $val) = each %{$self->{'_params'}}) {
		$paramHash{$key} = $val;
 	}
	return \%paramHash;
}

################################################################################
# Result mgmt
################################################################################

sub addResult {
	my $self = shift;
	my $key = shift;
	my $val = shift;

	${$self->{'_results'}}{$key} = $val;
}

sub setResultFirst {
	my $self = shift;
	my $key = shift;
	my $val = shift;

	#${$self->{'_results'}}{$key} = $val;
	
#	(tied %{$self->{'_results'}})->first($key => $val);

	if ($self->{'_useixhash'}) {
		(tied %{$self->{'_results'}})->Unshift($key => $val);
	} else {
		${$self->{'_results'}}{$key} = $val;
	}
}

sub addResultLoop {
	my $self = shift;
	my $loop = shift;
	my $loopidx = shift;
	my $key = shift;
	my $val = shift;

	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (!defined ${$self->{'_results'}}{$loop}) {
		${$self->{'_results'}}{$loop} = [];
	}
	
	if (!defined ${$self->{'_results'}}{$loop}->[$loopidx]) {
		my %paramHash;
		tie %paramHash, 'Tie::IxHash' if $self->{'_useixhash'};
		
		${$self->{'_results'}}{$loop}->[$loopidx] = \%paramHash;
	}
	
	${${$self->{'_results'}}{$loop}->[$loopidx]}{$key} = $val;
}

# same as addResultLoop but checks first the value is defined.
sub addResultLoopIfValueDefined {
	my $self = shift;
	my $loop = shift;
	my $loopidx = shift;
	my $key = shift;
	my $val = shift;

	if (defined $val) {
		$self->addResultLoop($loop, $loopidx, $key, $val);
	}
}

sub setResultLoopHash {
	my $self = shift;
	my $loop = shift;
	my $loopidx = shift;
	my $hashRef = shift;
	
	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (!defined ${$self->{'_results'}}{$loop}) {
		${$self->{'_results'}}{$loop} = [];
	}
	
	${$self->{'_results'}}{$loop}->[$loopidx] = $hashRef;
}

sub sliceResultLoop {
	my $self     = shift;
	my $loop     = shift;
	my $start    = shift;
	my $quantity = shift || 0;
	
	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (defined ${$self->{'_results'}}{$loop}) {
		
		if ($start) {
			splice ( @{${$self->{'_results'}}{$loop}} , 0, $start);
		}
		if ($quantity) {
			splice ( @{${$self->{'_results'}}{$loop}} , $quantity);
		}
	}
}

sub string {
	my $self   = shift;
	my $string = shift;

	my $client = $self->client();

	return cstring($client, $string);
}


# sortResultLoop
# sort the result loop $loop using field $field.
sub sortResultLoop {
	my $self     = shift;
	my $loop     = shift;
	my $field    = shift;
	
	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (defined ${$self->{'_results'}}{$loop}) {
		my @data;
		
		if ($field == 'weight') {
			@data = sort { $a->{$field} <=> $b->{$field} } @{${$self->{'_results'}}{$loop}};
		} else {
			@data = sort { $a->{$field} cmp $b->{$field} } @{${$self->{'_results'}}{$loop}};
		}
		${$self->{'_results'}}{$loop} = \@data;
	}
}

sub isValidQuery {
	my $self = shift;
	return $self->{'_isQuery'};
}

sub getResults {
	my $self = shift;
	
	return $self->{'_results'};
}

sub setRawResults {
	my $self = shift;
	
	$self->{'_results'} = shift;
}

sub getResult {
	my $self = shift;
	my $key = shift || return;
	
	return ${$self->{'_results'}}{$key};
}

sub getResultLoopCount {
	my $self = shift;
	my $loop = shift;
	
	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (defined ${$self->{'_results'}}{$loop}) {
		return scalar(@{${$self->{'_results'}}{$loop}});
	}
}

sub getResultLoop {
	my $self = shift;
	my $loop = shift;
	my $loopidx = shift;
	my $key = shift || return undef;

	if ($loop =~ /^@(.*)/) {
		$loop = $1 . "_loop";
		$log->warn("Loop starting with \@: $1 -- deprecated; please use $1_loop");
	}
	if ($loop !~ /.*_loop$/) {
		$loop = $loop . '_loop';
	}
	
	if (defined ${$self->{'_results'}}{$loop} && 
		defined ${$self->{'_results'}}{$loop}->[$loopidx]) {
		
			return ${${$self->{'_results'}}{$loop}->[$loopidx]}{$key};
	}
	return undef;
}

sub cleanResults {
	my $self = shift;

	my %resultHash;

	tie %resultHash, 'Tie::IxHash' if $self->{'_useixhash'};
	
	# not sure this helps release memory, but can't hurt
	delete $self->{'_results'};

	$self->{'_results'} = \%resultHash;
	
	# this will reset it to dispatchable so we can execute it once more
	$self->validate();
}


################################################################################
# Compound calls
################################################################################

# accepts a reference to an array containing references to arrays containing
# synonyms for the query names, 
# and returns 1 if no name match the request. Used by functions implementing
# queries to check the dispatcher did not send them a wrong request.
# See Queries.pm for usage examples, for example infoTotalQuery.
sub isNotQuery {
	return !$_[0]->{'_isQuery'} || !$_[0]->__matchingRequest($_[1]);
}

# same for commands
sub isNotCommand {
	return $_[0]->{'_isQuery'} || !$_[0]->__matchingRequest($_[1]);
}

sub isCommand{
	return !$_[0]->{'_isQuery'} && $_[0]->__matchingRequest($_[1]);
}

sub isQuery{
	return $_[0]->{'_isQuery'} && $_[0]->__matchingRequest($_[1]);
}


# sets callback parameters (function and arguments) in a single call...
sub callbackParameters {
	my $self = shift;
	my $callbackf = shift;
	my $callbackargs = shift;

	$self->{'_cb_func'} = $callbackf;
	$self->{'_cb_args'} = $callbackargs;	
}

# returns true if $param is undefined or not one of the possible values
# not really a method on request data members but defined as such since it is
# useful for command and queries implementation.
sub paramUndefinedOrNotOneOf {
	my $self = shift;
	my $param = shift;
	my $possibleValues = shift;

	return 1 if !defined $param;
	return 1 if !defined $possibleValues;
	return !grep($_ eq $param, @{$possibleValues});
}

# returns true if $param being defined, it is not one of the possible values
# not really a method on request data members but defined as such since it is
# useful for command and queries implementation.
sub paramNotOneOfIfDefined {
	my $self = shift;
	my $param = shift;
	my $possibleValues = shift;

	return 0 if !defined $param;
	return 1 if !defined $possibleValues;
	return !grep($_ eq $param, @{$possibleValues});
}

# not really a method on request data members but defined as such since it is
# useful for command and queries implementation.
sub normalize {
	my $self = shift;
	my $from = shift;
	my $numofitems = shift;
	my $count = shift;
	
	my $start = 0;
	my $end   = 0;
	my $valid = 0;
	
	if ($numofitems && $count) {

		my $lastidx = $count - 1;

		if ($from > $lastidx) {
			return ($valid, $start, $end);
		}

		if ($from < 0) {
			$from = 0;
		}
	
		$start = $from;
		$end = $start + $numofitems - 1;
	
		if ($end > $lastidx) {
			$end = $lastidx;
		}

		$valid = 1;
	}

	return ($valid, $start, $end);
}


################################################################################
# Other
################################################################################

# execute the request
sub execute {
	my $self = shift;

	if ($log->is_info) {
		$self->dump("Request");
	}

	$::perfmon && (my $now = Time::HiRes::time());

	# some time may have elapsed between the request creation
	# and its execution, and the client, f.e., could have disappeared
	# check all is OK once more...
	$self->validate();

	# do nothing if something's wrong
	if ($self->isStatusError()) {

		$log->error('Request in error, returning');

		return;
	}
	
	# call the execute function
	if (my $funcPtr = $self->{'_func'}) {

		# notify for commands
		# done here so that order of calls is maintained in all cases.
		if (!$self->query()) {
		
			push @notificationQueue, $self;
		}

		eval { &{$funcPtr}($self) };

		if ($@) {
			my $funcName = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
			logError("While trying to run function coderef [$funcName]: [$@]");
			$self->setStatusBadDispatch();
			$self->dump('Request');
			
			if ( main::SLIM_SERVICE ) {
				SDI::Service::Control->mailError( "Request crash: $funcName", $@ );
			}
		}
	}
	
	# contine execution unless the Request is still work in progress (async)...
	$self->executeDone() unless $self->isStatusProcessing();

	$::perfmon && $now && $requestTask->log(Time::HiRes::time() - $now, "Execute: ", $self->{'_func'});
}

# perform end of execution, calling the callback etc...
sub executeDone {
	my $self = shift;
	
	# perform the callback
	# do it unconditionally as it is used to generate the response web page
	# smart callback routines test the request status!
	$self->callback();
		
	if (!$self->isStatusDone()) {
	
		# remove the notification if we pushed it...
		my $notif = pop @notificationQueue;
		
		if ((defined $notif) && ($notif != $self)) {
		
			# oops wrong one, repush it...
			push @notificationQueue, $notif;
		}
	}

	if ($log->is_debug) {

		$log->debug($self->dump('Request'));
	}
}

# allows re-calling the function. Basically a copycat of execute, without
# notification. This enables 
sub jumpbacktofunc {
	my $self = shift;
	
	# do nothing if we're done
	if ($self->isStatusDone()) {

		logError('Called on done request, exiting');
		return;
	}

	# check we're still good
	$self->validate();

	# do nothing if something's wrong
	if ($self->isStatusError()) {

		logError('Called on done request, exiting');
		return;
	}

	# call the execute function
	if (my $funcPtr = $self->{'_func'}) {

		eval { &{$funcPtr}($self) };

		if ($@) {

			logError("While trying to run function coderef: [$@]");

			$self->setStatusBadDispatch();
			$self->dump('Request');
			
			if ( main::SLIM_SERVICE ) {
				my $name = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
				SDI::Service::Control->mailError( "Request crash: $name", $@ );
			}
		}
	}
	
	# contine execution unless the Request is still work in progress (async)...
	$self->executeDone() unless $self->isStatusProcessing();	
}

# perform callback if defined
sub callback {
	my $self = shift;

	# do nothing unless callback is enabled
	if ($self->callbackEnabled()) {
		
		if (defined(my $funcPtr = $self->callbackFunction())) {

			$log->info("Calling callback function");

			my $args = $self->callbackArguments();
		
			# if we have no arg, use the request
			if (!defined $args) {

				eval { &$funcPtr($self) };

				if ($@) { 
					logError("While trying to run function coderef: [$@]");
					$self->dump('Request');
					
					if ( main::SLIM_SERVICE ) {
						my $name = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
						SDI::Service::Control->mailError( "Request crash: $name", $@ );
					}
				}
			
			# else use the provided arguments
			} else {

				# This is a hack to make passing back of the "@p" array work. But limit it to
				# generateHTTPResponse, as Jonas Salling is the only caller.
				if (Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr) =~ /::generateHTTPResponse$/) {

					push @$args, [ $self->renderAsArray ];
				}

				eval { &$funcPtr(@$args) };

				if ($@) { 
					logError("While trying to run function coderef: [$@]");
					$self->dump('Request');
					
					if ( main::SLIM_SERVICE ) {
						my $name = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
						SDI::Service::Control->mailError( "Request crash: $name", $@ );
					}
				}
			}
		}

	} else {

		$log->info("Callback disabled");
	}
}

# notify listeners...
sub notify {
	my $self = shift || return;
	my $specific = shift; # specific target of notify if we have a single known target

	if ( $log->is_debug ) {
		$log->debug(sprintf("Notifying %s", $self->getRequestString()));
	}

	# process listeners if we match the super regexp (i.e. there is an interested listener)
	if ($self->{'_requeststr'} =~ $listenerSuperRE) {
		
		for my $listener (values %listeners) {

			# skip unless we match the listener filter
			next unless $self->{'_requeststr'} =~ $listener->[0];

			my $notifyFuncRef = $listener->[1];
			my $clientid      = $listener->[3];
			
			# If this listener is client-specific, ignore unless we have that client
			if ( $clientid ) {
				unless ( blessed( $self->client ) && $self->client->id eq $clientid ) {
					$log->debug( "Skipping notification, only wanted for $clientid" );
					next;
				}
			}

			if ( $log->is_debug ) {
				my $funcName = $listener;
				
				if ( ref($notifyFuncRef) eq 'CODE' ) {
					$funcName = Slim::Utils::PerlRunTime::realNameForCodeRef($notifyFuncRef);
				}
				
				$log->debug(sprintf("Notifying %s of %s =~ %s",
									$funcName, $self->getRequestString, __filterString($listener->[2])
								   ));
			}
			
			$::perfmon && (my $now = Time::HiRes::time());
			
			eval { &$notifyFuncRef($self) };
			
			if ($@) {
				logError("Failed notify: $@");
				
				if ( main::SLIM_SERVICE ) {
					my $name = Slim::Utils::PerlRunTime::realNameForCodeRef($notifyFuncRef);
					SDI::Service::Control->mailError( "Request crash: $name", $@ );
				}
			}
			
			$::perfmon && $requestTask->log(Time::HiRes::time() - $now, "Notify: ", $notifyFuncRef);
		}
	}
	
	# handle subscriptions
	# send the notification to all filters...
	for my $cnxid (keys %subscribers) {
		for my $name ($specific || keys %{$subscribers{$cnxid}}) {
			for my $clientid (keys %{$subscribers{$cnxid}{$name}}) {
				
				my $request = $subscribers{$cnxid}{$name}{$clientid};
				
				my $relevant = 1;
				
				if (defined(my $funcPtr = $request->autoExecuteFilter())) {
				
					$relevant = 0;
					
					if (ref($funcPtr) eq 'CODE') {
				
						eval { $relevant = &{$funcPtr}($request, $self) };
				
						if ($@) {
							my $funcName = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
							logError("While trying to run function coderef [$funcName]: [$@]");
							
							if ( main::SLIM_SERVICE ) {
								SDI::Service::Control->mailError( "Request crash: $funcName", $@ );
							}
							
							next;
						}
					}
				}
				
				if ($relevant) {
					
					# delay answers by the amount returned by relevant-1
					Slim::Utils::Timers::killOneTimer($request,
						\&__autoexecute);

					Slim::Utils::Timers::setTimer($request, 
						Time::HiRes::time() + $relevant - 1,
						\&__autoexecute);

#					$request->__autoexecute();
				}
			}
		}
	}
}


=head2 registerAutoExecute ( timeout, filterFunc )

Register ourself as subscribed to. Autoexecute after timeout
(if > 0) or if filterFunc returns 1 when sent notifications.

=cut
sub registerAutoExecute{
	my $self = shift || return;
	my $timeout = shift;
	my $filterFunc = shift;
	my $cleanupFunc = shift;
	
	$log->debug("registerAutoExecute()");
	
	# we shall be a query
	return unless $self->{'_isQuery'};
	
	# we shall have a defined connectionID
	my $cnxid = $self->connectionID() || return;
	
	# requests with a client are remembered by client
	my $clientid = $self->clientid() || 'global';
	
	# requests are remembered by kind
	my $name = $self->getRequestString();
	
	# store the filterFunc in the request
	$self->autoExecuteFilter($filterFunc);
	
	# store cleanup function if it exists - this is called whenever the autoexecute is cancelled
	if ($cleanupFunc) {
		$self->autoExecuteCleanup($cleanupFunc);
	}

	# kill any previous subscription we might have laying around 
	# (for this query/client/connection)
	my $oldrequest = $subscribers{$cnxid}{$name}{$clientid};

	if (defined $oldrequest) {

		$log->info("Old friend: $cnxid - $name - $clientid");

		delete $subscribers{$cnxid}{$name}{$clientid};

		# call old cleanup if it exists and is different from the cleanup for new request
		if (my $cleanup = $oldrequest->autoExecuteCleanup()) {
			if (!$cleanupFunc || $cleanupFunc != $cleanup) {
				eval { &{$cleanup}($oldrequest, $cnxid) };
			}
		}

		Slim::Utils::Timers::killTimers($oldrequest, \&__autoexecute);
	}
	else {
		$log->info("New buddy: $cnxid - $name - $clientid");
	}
	
	# store the new subscription if this is what is asked of us
	if ($timeout ne '-') {
		
		$log->debug(".. set ourself up");

		# copy the request
		my $request = $self->virginCopy();

		$subscribers{$cnxid}{$name}{$clientid} = $request;

		if ($timeout > 0) {
			$log->debug(".. starting timer: $timeout");
			# start the timer
			Slim::Utils::Timers::setTimer($request, 
				Time::HiRes::time() + $timeout,
				\&__autoexecute);
		}
	}
}

=head2 fixencoding ( )

Handle encoding for external commands.

=cut
sub fixEncoding {
	my $self = shift || return;
	
	my $encoding = ${$self->{'_params'}}{'charset'} || return;

	while (my ($key, $val) = each %{$self->{'_params'}}) {

		if (!ref($val)) {

			${$self->{'_params'}}{$key} = Slim::Utils::Unicode::decode($encoding, $val);
		}
	}
}

################################################################################
# Legacy
################################################################################
# support for legacy applications

# perform the same feat that the old execute: array in, array out
sub executeLegacy {
	my $client = shift;
	my $parrayref = shift;

	# create a request from the array - using ixhashes so renderAsArray works
	my $request = Slim::Control::Request->new( 
		(blessed($client) ? $client->id() : undef), 
		$parrayref,
		undef,
		1,
	);
	
	if (defined $request) {

		return $request->renderAsArray;
	}
}

# returns the request as an array
sub renderAsArray {
	my $self = shift;
	my $encoding = shift;

	if (!$self->{'_useixhash'}) {
		logBacktrace("request should set useIxHashes in Slim::Control::Request->new()");
	}

	my @returnArray;
	
	# conventions: 
	# -- parameter or result with key starting with "_": value outputted
	# -- parameter or result with key starting with "__": no output
	# -- result starting with key ending in "_loop": is a loop
	# -- anything else: output "key:value"
	
	# push the request terms
	push @returnArray, @{$self->{'_request'}};
	
	# push the parameters
	while (my ($key, $val) = each %{$self->{'_params'}}) {
		
		# no output
		next if ($key =~ /^__/);

		$val = Slim::Utils::Unicode::encode($encoding, $val) if $encoding;

		if ($key =~ /^_/) {
			push @returnArray, $val;
		} else {
			push @returnArray, ($key . ":" . $val);
		}
 	}
 	
 	# push the results
	while (my ($key, $val) = each %{$self->{'_results'}}) {

		# no output
		next if ($key =~ /^__/);

		# loop
		if ($key =~ /_loop$/) {

			# loop over each elements
			foreach my $hash (@{${$self->{'_results'}}{$key}}) {

				while (my ($key2, $val2) = each %{$hash}) {

					if ($encoding) {

						$val2 = Slim::Utils::Unicode::encode($encoding, $val2);
					}

					if ($key2 =~ /^__/) {
						# no output
					} elsif ($key2 =~ /^_/) {
						push @returnArray, $val2;
					} else {
						push @returnArray, ($key2 . ':' . $val2);
					}
				}	
			}
			next;
		}
		
		# array unrolled
#		if ($key =~ /^$_(.+)/)
		
		if (ref $val eq 'ARRAY') {
			$val = join (',', @{$val})
		}
		if (ref $val eq 'SCALAR') {		
			$val = Slim::Utils::Unicode::encode($encoding, $val) if $encoding;
		}
		
		if ($key =~ /^_/) {
			push @returnArray, $val;
		} else {
			push @returnArray, ($key . ':' . $val);
		}
 	}

	return @returnArray;
}

################################################################################
# Utility function to dump state of the request object to stdout
################################################################################
sub dump {
	my $self = shift;
	my $introText = shift || '?';

	my $str = $introText . ": ";

	if ($self->query()) {
		$str .= 'Query ';
	} else {
		$str .= 'Command ';
	}

	if (my $client = $self->client()) {
		my $clientid = $client->id();
		$str .= "[$clientid->" . $self->getRequestString() . "]";
	} else {
		$str .= "[" . $self->getRequestString() . "]";
	}

	if ($self->callbackFunction()) {

		if ($self->callbackEnabled()) {
			$str .= " cb+ ";
		} else {
			$str .= " cb- ";
		}
	}

	if ($self->source()) {
		$str .= " from " . $self->source() ." ";
	}

	$str .= ' (' . $self->getStatusText() . ")";

	$log->info($str);

	while (my ($key, $val) = each %{$self->{'_params'}}) {

			$log->info("   Param: [$key] = [$val]");
 	}

	while (my ($key, $val) = each %{$self->{'_results'}}) {

		if ($key =~ /_loop$/) {

			my $count = scalar @{${$self->{'_results'}}{$key}};

			$log->info("   Result: [$key] is loop with $count elements:");

			# loop over each elements
			for (my $i = 0; $i < $count; $i++) {

				my $hash = ${$self->{'_results'}}{$key}->[$i];

				while (my ($key2, $val2) = each %{$hash}) {
					$log->info("   Result:   $i. [$key2] = [$val2]");
				}	
			}

		} else {
			$log->info("   Result: [$key] = [$val]");
		}
 	}
}

################################################################################
# Private methods
################################################################################

# this is hot so optimised for speed
sub __matchingRequest {
	# $_[0] = self
	# $_[1] = possibleNames in the form of an arrayref of arrayrefs
	my $request = $_[0]->{'_request'};
	my $i = 0;

	for my $names (@{$_[1]}) {
		my $req = $request->[$i++];
		if (!grep($_ eq $req, @$names)) {
			return 0;
		}
	}

	return 1;
}

# return compiled regexp representing the $possibleNames array of arrays
sub __requestRE {
	my $possibleNames = shift || return qr /./; 
	my $regexp = '';

	my $i = 0;

	for my $names (@$possibleNames) {
		$regexp .= ',' if $i++;
		$regexp .= (scalar @$names > 1) ? '(?:' . join('|', @$names) . ')' : $names->[0];
	}

	return qr /$regexp/;
}

# update the super filter used by notify
# this builds a regexp matching any of the first level verbs the listeners are interested in
# or /./ if there is a listener with no requestRef filter specified
sub __updateListenerSuperRE {

	my %names;
	my $regexp;

	for my $listener (values %listeners) {

		my $requestsRef = $listener->[2];

		if (!defined $requestsRef) {
			$regexp = '.';
			last;
		}

		map { $names{$_} = 1 } @{$requestsRef->[0]};
	}

	$regexp ||= join('|', keys %names);

	$listenerSuperRE = qr /$regexp/;

	$log->debug("updated listener superRE: $listenerSuperRE");
}

# returns a string corresponding to the notification filter, used for 
# debugging
sub __filterString {
	my $requestsRef = shift;
	
	if (!defined $requestsRef) {

		return "(no filter)";
	}
	
	my $str = "[";

	foreach my $req (@$requestsRef) {
		$str .= "[";
		my @list = map { "\'$_\'" } @$req;
		$str .= join(",", @list);
		$str .= "]";
	}
		
	$str .= "]";
}

# given a command or query in an array, walk down the dispatch DB to find
# the function to call for it. Used by the Request constructor
sub __parse {
	my $self           = shift;
	my $requestLineRef = shift; # reference to an array containing the query verbs

	my $isDebug    = $log->is_debug;

	if ($isDebug) {
		$log->debug("Request: parse(" . join(' ', @{$requestLineRef}) . ")");
	}

	my $found;					# have we found the right command
	my $outofverbs;					# signals we're out of verbs to try and match
	my $LRindex    = 0;				# index into $requestLineRef
	my $done       = 0;				# are we done yet?
	my $DBp        = \%dispatchDB;	# pointer in the dispatch table
	my $match      = $requestLineRef->[$LRindex]; # verb of the command we're trying to match
	my @request;
	my $params     = $self->{'_params'};
	my $curparam   = 0;

	while (!$done) {

		# we're out of verbs to check for a match -> try with ''
		if (!defined $match) {

			$match = '';
			$outofverbs = 1;
		}

		if ($isDebug) {
			$log->debug("..Trying to match [$match]");
			#$log->debug(Data::Dump::dump($DBp));
		}

		# our verb does not match in the hash 
		if (!defined $DBp->{$match}) {

			if ($isDebug) {

				$log->debug("..no match for [$match]");
			}
			
			# if $match is '?', abandon ship
			if ($match eq '?') {

				$log->debug("...[$match] is ?, done");
				$done = 1;

			} else {

				my $foundparam = 0;

				# Can we find a key that starts with '_' ?
				if ($isDebug) {
					$log->debug("...looking for a key starting with _");
				}

				for my $key (keys %{$DBp}) {

					if ($isDebug) {
						$log->debug("....considering [$key]");
					}
					
					if ($key =~ /^_.*/) {

						if ($isDebug) {
							$log->debug("....[$key] starts with _");
						}

						# found it, add $key=$match to the params
						if (!$outofverbs) {

							if ($isDebug) {
								$log->debug("....not out of verbs, adding param [$key, $match]");
							}

							$params->{$key} = $match;
							++$curparam;
						}

						# and continue with $key...
						$foundparam = 1;
						$match = $key;
						last;
					}
				}

				if (!$foundparam) {
					$done = 1;
				}
			}
		}

		# Our verb matches, and it is an array -> done
		if (!$done && ref $DBp->{$match} eq 'ARRAY') {

			if ($isDebug) {
				$log->debug("..[$match] is ARRAY -> done");
			}

			if ($match ne '' && !($match =~ /^_.*/) && $match ne '?') {

				# add $match to the request list if it is something sensible
				push @request, $match;
			}

			# we're pointing to an array -> done
			$done = 1;
			$found = $DBp->{$match};
		}

		# Our verb matches, and it is a hash -> go to next level
		# (no backtracking...)
		if (!$done && ref $DBp->{$match} eq 'HASH') {

			if ($isDebug) {	
				$log->debug("..[$match] is HASH");
			}

			if ($match ne '' && !($match =~ /^_.*/) && $match ne '?') {

				# add $match to the request list if it is something sensible
				push @request, $match;
			}

			$DBp = \%{$DBp->{$match}};
			$match = $requestLineRef->[++$LRindex];
		}
	}

	# create a string containg all request verbs to test against with a regexp
	$self->{'_request'}    = \@request;
	$self->{'_requeststr'} = join(',', @request);

	if (defined $found) {
		# 0: needs client
		# 1: is a query
		# 2: has Tags
		# 3: Function
		
		# handle the remaining params
		for (my $i = ++$LRindex; $i < scalar @{$requestLineRef}; $i++) {

			# try tags if we know we have some
			if ($found->[2] && ($requestLineRef->[$i] =~ /([^:]+):(.*)/)) {

				$params->{$1} = $2;
				++$curparam;

			} else {

				# default to positional param...
				$params->{ "_p" . $curparam++ } = $requestLineRef->[$i];
			}
		}

		$self->{'_needClient'} = $found->[0];
		$self->{'_isQuery'} = $found->[1];
		$self->{'_func'} = $found->[3];

	} else {

		# don't complain loudly here
		# the request will end up as invalid. If this causes a problem, the caller can complain.
		# we do not have to 
		if ( $log->is_info ) {
			$log->info("Request [" . join(' ', @{$requestLineRef}) . "]: no match in dispatchDB!");
		}

		# handle the remaining params, if any...
		# only for the benefit of CLI echoing...
		for (my $i = $LRindex; $i < scalar @{$requestLineRef}; $i++) {

			$params->{ "_p" . $curparam++ } = $requestLineRef->[$i];
		}
	}

	$self->{'_curparam'} = $curparam;
}

# callback for the subscriptions.
sub __autoexecute{
	my $self = shift;
	
	$log->debug("__autoexecute()");
	
	# we shall have somewhere to callback to
	my $funcPtr = $self->autoExecuteCallback() || return;
	
	return unless ref($funcPtr) eq 'CODE';
	
	# we shall have a connection id to send as param
	my $cnxid = $self->connectionID() || return;
	
	# delete the sub in case of error
	my $deleteSub = 0;
	
	# execute ourself after some cleanup
	$self->cleanResults;
	$self->execute();
	
	if ($self->isStatusError()) {
		$deleteSub = 1;
	}
	
	# execute the callback in all cases.
	eval { &{$funcPtr}($self, $cnxid) };

	# oops, failed
	if ($@) {
		my $funcName = Slim::Utils::PerlRunTime::realNameForCodeRef($funcPtr);
		logError("While trying to run function coderef [$funcName]: [$@] => deleting subscription");
		$deleteSub = 1;
		
		if ( main::SLIM_SERVICE ) {
			SDI::Service::Control->mailError( "Request crash: $funcName", $@ );
		}
	}
	
	if ($deleteSub) {
		my $name = $self->getRequestString();
		my $clientid = $self->clientid() || 'global';
		my $request2del = delete $subscribers{$cnxid}{$name}{$clientid};
		$log->debug("__autoexecute: deleting $cnxid - $name - $clientid");
		if (my $cleanup = $self->autoExecuteCleanup()) {
			eval { &{$cleanup}($self, $cnxid) };
		}
		# there should not be any of those, but just to be sure
		Slim::Utils::Timers::killTimers($self, \&__autoexecute);
		Slim::Utils::Timers::killTimers($request2del, \&__autoexecute);
	}

}

=head1 SEE ALSO

=cut

1;

__END__
