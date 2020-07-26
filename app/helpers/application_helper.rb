module ApplicationHelper
  def header_tabs
    sanitize("#{tabs_header}#{user_profile}#{sign_in_sign_up}#{admin_tabs}#{sign_out}#{tabs_footer}", attributes: %w[data-method href class])
  end

  def tabs_header
    <<-html
    <div class="fixed">
      <nav class="top-bar" data-topbar="">
        <section class="top-bar-section">
          <ul class="left">
            <li class="active"><a href="/" class="tab">Home</a></li>
            <li><a href="/pages/about" class="tab">About</a></li>
    html
  end

  def user_profile
    return unless current_user
    <<-html
            <li><a href="/users/edit" class="tab">Profile</a></li>
    html
  end

  def sign_in_sign_up
    return if current_user
    <<-html
            <li><a href="/users/sign_in" class="tab">Sign in</a></li>
            <li><a href="/users/sign_up" class="tab">Sign up</a></li>
    html
  end

  def sign_out
    return unless current_user
    <<-html
            <li>#{link_to('Sign out', '/users/sign_out', method: 'delete', class: 'tab')}</li>
    html
  end

  def admin_tabs
    return unless current_user&.is_admin?
    <<-html
            <li><a href="/users" class="tab">Users</a></li>
            <li><a href="/jewels" class="tab">Jewels</a></li>
    html
  end

  def tabs_footer
    <<-html
          </ul>
        </section>
      </nav>
    </div>
    html
  end
end
