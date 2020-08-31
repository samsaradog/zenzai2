module ApplicationHelper
  def header_tabs
    raw("#{tabs_header}#{user_profile}#{sign_in_sign_up}#{admin_tabs}#{sign_out}#{tabs_footer}")
  end

  def tabs_header
    <<-html
      <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active"><a href="/" class="nav-link">Home</a></li>
            <li class="nav-item dropdown">
               <a class="nav-link dropdown-toggle" href="#" id="aboutDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                 About
               </a>
               <div class="dropdown-menu" aria-labelledby="aboutDropdown">
                 <a class="dropdown-item" href="/pages/about">Welcome</a>
                 <a class="dropdown-item" href="/pages/zenzai">Zenzai</a>
                 <a class="dropdown-item" href="/pages/support">Support</a>
               </div>
            </li>
    html
  end

  def user_profile
    return unless current_user
    <<-html
            <li><a href="/users/edit" class="nav-link">Profile</a></li>
    html
  end

  def sign_in_sign_up
    return if current_user
    <<-html
            <li><a href="/users/sign_in" class="nav-link">Sign in</a></li>
            <li><a href="/users/sign_up" class="nav-link">Sign up</a></li>
    html
  end

  def sign_out
    return unless current_user
    <<-html
            <li>#{link_to('Sign out', '/users/sign_out', method: 'delete', class: 'nav-link')}</li>
    html
  end

  def admin_tabs
    return unless current_user&.is_admin?
    <<-html
            <li><a href="/users" class="nav-link">Users</a></li>
            <li><a href="/jewels" class="nav-link">Jewels</a></li>
    html
  end

  def tabs_footer
    <<-html
          </ul>
        </div>
      </nav>
    html
  end
end
