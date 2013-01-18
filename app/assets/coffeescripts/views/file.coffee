window.FileTemplate = '''
	<li class="file <% if(file.complete){ %>complete<% } %>">
	<a href="#" class="destroy">x</a>
	<p class="name"><%= file.name %></p>
	<p class="size"><%= file.size %></p>
	<p class="progress"><%= file.progress %></p>
	<p class="speed"><%= file.speed %></p>
	</li>
'''
