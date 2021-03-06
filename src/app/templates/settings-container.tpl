<div class="settings-container">
	<div class="fa fa-times close-icon"></div>
	<div class="success_alert" style="display:none"><%= i18n.__("Saved") %>&nbsp;<span id="checkmark-notify"><div id="stem-notify"></div><div id="kick-notify"></div></span></div>
	
	<section id="title">
		<div class="title"><%= i18n.__("Settings") %></div>
		<div class="content">
			<span>
				<i class="fa fa-keyboard-o help"></i>
				<input id="show-advanced-settings" class="settings-checkbox" name="showAdvancedSettings" type="checkbox" <%=(Settings.showAdvancedSettings? "checked":"")%>>
				<label class="settings-label" for="show-advanced-settings"><%= i18n.__("Show advanced settings") %></label>
			</span>
		</div>
	</section>
	
	<section id="user-interface">
		<div class="title"><%= i18n.__("User Interface") %></div>
		<div class="content">
			<span>
				<div class="dropdown subtitles-language">
					<p><%= i18n.__("Default Language") %>:</p>
					<%
						var langs = "";
						for(var key in App.Localization.allTranslations) {
								key = App.Localization.allTranslations[key];
								if (App.Localization.langcodes[key] !== undefined) {
								langs += "<option "+(Settings.language == key? "selected='selected'":"")+" value='"+key+"'>"+
											App.Localization.langcodes[key].nativeName+"</option>";
							}
						}
					%>
					<select name="language"><%=langs%></select>
					<div class="dropdown-arrow"></div>
				</div>
			</span>
						
			<span>
				<div class="dropdown pct-theme">
					<p><%= i18n.__("Theme") %>:</p>
					<%
						var themes = "";
						var theme_files = fs.readdirSync('./src/app/themes/');
						for (var i in theme_files) {
							if (theme_files[i].indexOf('_theme') > -1) {
								themes += "<option " + (Settings.theme == theme_files[i].slice(0, -4)? "selected='selected'" : "") + " value='" + theme_files[i].slice(0, -4) + "'>" +
								theme_files[i].slice(0, -10).split('_').join(' '); + "</option>";
							}
						}
					%>
					<select name="theme"><%=themes%></select>
					<div class="dropdown-arrow"></div>
				</div>		
			</span>

			<span class="advanced">
				<input class="settings-checkbox" name="coversShowRating" id="cb3" type="checkbox" <%=(Settings.coversShowRating? "checked='checked'":"")%>>
				<label class="settings-label" for="cb3"><%= i18n.__("Show movie rating on the cover") %></label>
			</span>
				
			<span class="advanced">
				<input class="settings-checkbox" name="fadeWatchedCovers" id="cbfade" type="checkbox" <%=(Settings.fadeWatchedCovers? "checked='checked'":"")%>>
				<label class="settings-label" for="cbfade"><%= i18n.__("Fade watched items") %></label>
			</span>
				
			<span class="advanced">
				<input class="settings-checkbox" name="alwaysOnTop" id="cb4" type="checkbox" <%=(Settings.alwaysOnTop? "checked='checked'":"")%>>
				<label class="settings-label" for="cb4"><%= i18n.__("Always On Top") %></label>
			</span>

		</div>
	</section>

	<section id="subtitles">
		<div class="title"><%= i18n.__("Subtitles") %></div>
		<div class="content">
			<span>
				<div class="dropdown subtitles-language-default">
					<p><%= i18n.__("Default Subtitle") %>:</p>
					<%
						var sub_langs = "<option "+(Settings.subtitle_language == "none"? "selected='selected'":"")+" value='none'>" +
											i18n.__("Disabled") + "</option>";

						for(var key in App.Localization.langcodes) {
							if (App.Localization.langcodes[key].subtitle !== undefined && App.Localization.langcodes[key].subtitle == true) {
								sub_langs += "<option "+(Settings.subtitle_language == key? "selected='selected'":"")+" value='"+key+"'>"+
												App.Localization.langcodes[key].nativeName+"</option>";
							}
						}
					%>
					<select name="subtitle_language"><%=sub_langs%></select>
					<div class="dropdown-arrow"></div>
				</div>

				<div class="dropdown subtitles-size">
					<p><%= i18n.__("Size") %>:</p>
					<%
						var arr_sizes = ["24px","26px","28px","30px","32px","34px","36px","38px","48px","50px","52px","54px","56px","58px","60px"];

						var sub_sizes = "";
						for(var key in arr_sizes) {
							sub_sizes += "<option "+(Settings.subtitle_size == arr_sizes[key]? "selected='selected'":"")+" value='"+arr_sizes[key]+"'>"+arr_sizes[key]+"</option>";
						}
					%>
					<select name="subtitle_size"><%=sub_sizes%></select>
					<div class="dropdown-arrow"></div>
				</div>
			</span>
		</div>
	</section>
	
	<section id="quality" class="advanced">
		<div class="title"><%= i18n.__("Quality") %></div>
		<div class="content">
			<span>
				<div class="dropdown movies-quality">
					<p><%= i18n.__("Only list movies in") %>:</p>
					<select name="movies_quality">
						<option <%=(Settings.movies_quality == "all"? "selected='selected'":"") %> value="all"><%= i18n.__("All") %></option>
						<option <%=(Settings.movies_quality == "1080p"? "selected='selected'":"") %> value="1080p">1080p</option>
						<option <%=(Settings.movies_quality == "720p"? "selected='selected'":"") %> value="720p">720p</option>
					</select>
					<div class="dropdown-arrow"></div>
				</div>
			</span>
			<span>
				<input class="settings-checkbox" name="moviesShowQuality" id="cb1" type="checkbox" <%=(Settings.moviesShowQuality? "checked='checked'":"")%>>
				<label class="settings-label" for="cb1"><%= i18n.__("Show movie quality on list") %></label>
			</span>
		</div>
	</section>

	<section id="trakt-tv">
		<div class="title"><%= i18n.__("Trakt.tv") %></div>
		<div class="content">
			<div class="trakt-options<%= App.Trakt.authenticated ? " authenticated" : "" %>">
				<% if(App.Trakt.authenticated) { %>
					<span>
						<%= i18n.__("You are currently authenticated to Trakt.tv as") %> <%= Settings.traktUsername %>.
						<a id="unauthTrakt" class="unauthtext" href="#"><%= i18n.__("Disconnect account") %></a>
					</span>
					<span>
						<div class="btn-settings syncTrakt" id="syncTrakt">
							<i class="fa fa-refresh">&nbsp;&nbsp;</i>
							<%= i18n.__("Sync With Trakt") %>
						</div>
					</span>
				<% } else { %>
					<span>
						<%= i18n.__("Enter your Trakt.tv details here to automatically 'scrobble' episodes you watch in Popcorn Time") %>
					</span>
					<span>
						<p><%= i18n.__("Username") + ":" %></p>
						<input type="text" size="50" id="traktUsername" name="traktUsername">
							<div class="loading-spinner" style="display: none"></div>
							<div class="valid-tick" style="display: none"></div>
							<div class="invalid-cross" style="display: none"></div>
					</span>
					<span>
						<p><%= i18n.__("Password") + ":" %></p>
						<input type="password" size="50" id="traktPassword" name="traktPassword">
					</span>
					<span>
						<em><%= i18n.__("Popcorn Time stores an encrypted hash of your password in your local database") %></em>
					</span>
				<% } %>
			</div>
		</div>
	</section>

	<section id="remote-control" class="advanced">
		<div class="title"><%= i18n.__("Remote Control") %></div>
		<div class="content">
			<span>
				<p><%= i18n.__("HTTP API Port") + ":" %></p>
				<input id="httpApiPort" type="number" size="5" name="httpApiPort" value="<%=Settings.httpApiPort%>">
			</span>
			<span>
				<p><%= i18n.__("HTTP API Username") + ":" %></p>
				<input id="httpApiUsername" type="text" size="50" name="httpApiUsername" value="<%=Settings.httpApiUsername%>">
			</span>
			<span>
				<p><%= i18n.__("HTTP API Password") + ":" %></p>
				<input id="httpApiPassword" type="text" size="50" name="httpApiPassword" value="<%=Settings.httpApiPassword%>">
			</span>
		</div>
	</section>

	<section id="connection" class="advanced">
		<div class="title"><%= i18n.__("Connection") %></div>
		<div class="content">
			<span>
				<p><%= i18n.__("TV Show API Endpoint") + ":" %></p>
				<input id="tvshowApiEndpoint" type="text" size="50" name="tvshowApiEndpoint" value="<%=Settings.tvshowApiEndpoint%>">
			</span>
			<span>
				<p><%= i18n.__("Connection Limit") + ":" %></p>
				<input id="connectionLimit" type="text" size="20" name="connectionLimit" value="<%=Settings.connectionLimit%>"/>
			</span>
			<span>
				<p><%= i18n.__("DHT Limit") + ":" %></p>
				<input type="text" id="dhtLimit" size="20" name="dhtLimit" value="<%=Settings.dhtLimit%>"/>
			</span>
			<span>
				<p><%= i18n.__("Port to stream on") + ":" %></p>
				<input id="streamPort" type="text" size="20" name="streamPort" value="<%=Settings.streamPort%>"/>&nbsp;&nbsp;<em><%= i18n.__("0 = Random") %></em>
			</span>
		</div>
	</section>

	<section id="cache" class="advanced">
		<div class="title"><%= i18n.__("Cache Directory") %></div>
		<div class="content">
			<span>
				<p><%= i18n.__("Cache Directory") %>: </p>
				<input type="text" placeholder="<%= i18n.__("Cache Directory") %>" id="faketmpLocation" value="<%= Settings.tmpLocation %>" readonly="readonly" size="65" /> <i class="open-tmp-folder fa fa-folder-open-o"></i>
				<input type="file" name="tmpLocation" id="tmpLocation" nwdirectory style="display: none;" nwworkingdir="<%= Settings.tmpLocation %>" />
			</span>
			<span>
				<input class="settings-checkbox" name="deleteTmpOnClose" id="cb2" type="checkbox" <%=(Settings.deleteTmpOnClose? "checked='checked'":"")%>>
				<label class="settings-label" for="cb2"><%= i18n.__("Clear Tmp Folder after closing app?") %></label>
			</span>
		</div>
	</section>
		
	<div class="btns advanced">
		<div class="btn-settings flush-bookmarks"><%= i18n.__("Flush bookmarks database") %></div>
		<div class="btn-settings flush-subtitles"><%= i18n.__("Flush subtitles cache") %></div>
		<div class="btn-settings flush-databases"><%= i18n.__("Flush all databases") %></div>
		<div class="btn-settings default-settings"><%= i18n.__("Reset to Default Settings") %></div>
	</div>
		
</div>

