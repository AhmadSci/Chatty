defmodule StreamChatWeb.UserLoginLive do
  use StreamChatWeb, :live_view

  def render(assigns) do
    ~H"""
    <.logo />
    <div class="mx-auto max-w-sm">
      <.header class="text-center" >
        Sign in to account

        <:subtitle>
        Please enter your email and password to login and continue
        </:subtitle>
        </.header>
        <.simple_form
        :let={f}
        id="login_form"
        for={%{}}
        as={:user}
        action={~p"/users/log_in"}
        as={:user}
        phx-update="ignore"
        >
        <.input field={{f, :email}} type="email" label="Email" required />
        <.input field={{f, :password}} type="password" label="Password" required />
        <:actions :let={f}>
        <.input field={{f, :remember_me}} type="checkbox" label="Keep me logged in" />
        <.link style = "color:#747474" href={~p"/users/reset_password"} class="text-sm font-semibold">
        Forgot your password?
        </.link>
        </:actions>
        <:actions>
        <.button phx-disable-with="Signing in..." class="w-full">
        Sign in <span aria-hidden="true">→</span>
        </.button>
        </:actions>
        </.simple_form>
        <.header class="text-center" >
        <:subtitle>
          Don't have an account?
          <.link style = "color:#0D7377" navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
        </.header>
    </div>
    """
  end

  def logo(assigns) do
    ~H"""
    <div style = "display:flex; align-items:center; justify-content:center; margin-bottom:3rem">
      <svg width="121" height="44" viewBox="0 0 121 44" fill="none" xmlns="http://www.w3.org/2000/svg">
        <g clip-path="url(#clip0_109_2078)">
        <path d="M14.8223 29.6449L1.9122 33.3335C1.02425 33.5871 0.174976 32.829 0.326794 31.9179L2.11731 21.1749V4.23497C2.11731 3.1118 2.5635 2.03461 3.35771 1.2404C4.15191 0.446185 5.22912 0 6.35229 0H33.8795C35.0028 0 36.0802 0.446185 36.8744 1.2404C37.6686 2.03461 38.1145 3.1118 38.1145 4.23497V25.4099C38.1145 26.5331 37.6686 27.6103 36.8744 28.4045C36.0802 29.1987 35.0028 29.6449 33.8795 29.6449H14.8223Z" fill="#0D7377"/>
        <path d="M33.0001 40.8574L42.0876 43.4537C42.9755 43.7077 43.825 42.9493 43.6732 42.0385L42.4286 34.5717V22.0003C42.4286 21.1667 42.0974 20.3673 41.5081 19.7779C40.9188 19.1886 40.1193 18.8574 39.2858 18.8574H18.8572C18.0237 18.8574 17.2243 19.1886 16.6349 19.7779C16.0455 20.3673 15.7144 21.1667 15.7144 22.0003V37.7146C15.7144 38.5481 16.0455 39.3476 16.6349 39.9369C17.2243 40.5262 18.0237 40.8574 18.8572 40.8574H33.0001Z" fill="#14FFEC"/>
        </g>
        <path d="M59.622 32.62C57.718 32.62 56.062 32.276 54.654 31.588C53.246 30.884 52.166 29.892 51.414 28.612C50.662 27.332 50.286 25.844 50.286 24.148C50.286 21.796 50.726 19.708 51.606 17.884C52.502 16.06 53.71 14.652 55.23 13.66C56.75 12.652 58.438 12.148 60.294 12.148C62.022 12.148 63.334 12.596 64.23 13.492C65.126 14.372 65.574 15.54 65.574 16.996C65.574 17.972 65.398 18.756 65.046 19.348C64.71 19.94 64.222 20.236 63.582 20.236C63.134 20.236 62.782 20.132 62.526 19.924C62.27 19.716 62.142 19.412 62.142 19.012C62.142 18.868 62.174 18.604 62.238 18.22C62.334 17.74 62.382 17.356 62.382 17.068C62.382 15.612 61.606 14.884 60.054 14.884C58.998 14.884 57.99 15.228 57.03 15.916C56.07 16.604 55.294 17.62 54.702 18.964C54.11 20.292 53.814 21.876 53.814 23.716C53.814 25.636 54.35 27.124 55.422 28.18C56.494 29.22 58.078 29.74 60.174 29.74C61.214 29.74 62.262 29.612 63.318 29.356C64.39 29.084 65.574 28.676 66.87 28.132C67.11 28.036 67.31 27.988 67.47 27.988C67.726 27.988 67.918 28.084 68.046 28.276C68.174 28.468 68.238 28.716 68.238 29.02C68.238 29.996 67.71 30.716 66.654 31.18C65.518 31.676 64.334 32.044 63.102 32.284C61.886 32.508 60.726 32.62 59.622 32.62ZM79.6751 27.148C79.8831 27.148 80.0431 27.244 80.1551 27.436C80.2831 27.628 80.3471 27.892 80.3471 28.228C80.3471 28.868 80.1951 29.364 79.8911 29.716C79.1551 30.564 78.3951 31.26 77.6111 31.804C76.8431 32.348 75.9631 32.62 74.9711 32.62C74.1551 32.62 73.5391 32.388 73.1231 31.924C72.7071 31.444 72.4991 30.756 72.4991 29.86C72.4991 29.412 72.6111 28.612 72.8351 27.46C73.0431 26.452 73.1471 25.756 73.1471 25.372C73.1471 25.116 73.0591 24.988 72.8831 24.988C72.6751 24.988 72.3791 25.26 71.9951 25.804C71.6111 26.332 71.2271 27.036 70.8431 27.916C70.4591 28.796 70.1471 29.724 69.9071 30.7C69.6031 31.98 68.8511 32.62 67.6511 32.62C67.1711 32.62 66.8511 32.452 66.6911 32.116C66.5471 31.764 66.4751 31.14 66.4751 30.244C66.4751 29.732 66.4831 29.324 66.4991 29.02L66.5231 27.1C66.5231 24.636 66.7711 22.068 67.2671 19.396C67.7791 16.724 68.5231 14.484 69.4991 12.676C70.4911 10.852 71.6751 9.94 73.0511 9.94C73.7871 9.94 74.3791 10.26 74.8271 10.9C75.2911 11.524 75.5231 12.34 75.5231 13.348C75.5231 14.964 75.0511 16.644 74.1071 18.388C73.1631 20.116 71.6271 22.14 69.4991 24.46C69.4511 25.292 69.4271 26.148 69.4271 27.028C69.9551 25.668 70.5391 24.564 71.1791 23.716C71.8351 22.852 72.4751 22.236 73.0991 21.868C73.7391 21.5 74.3231 21.316 74.8511 21.316C75.8911 21.316 76.4111 21.836 76.4111 22.876C76.4111 23.5 76.2351 24.628 75.8831 26.26C75.5791 27.652 75.4271 28.572 75.4271 29.02C75.4271 29.66 75.6591 29.98 76.1231 29.98C76.4431 29.98 76.8191 29.788 77.2511 29.404C77.6991 29.004 78.2911 28.364 79.0271 27.484C79.2191 27.26 79.4351 27.148 79.6751 27.148ZM72.5471 12.316C72.2591 12.316 71.9391 12.732 71.5871 13.564C71.2351 14.38 70.8911 15.492 70.5551 16.9C70.2351 18.292 69.9711 19.812 69.7631 21.46C70.7551 20.292 71.5711 19.02 72.2111 17.644C72.8671 16.268 73.1951 15.02 73.1951 13.9C73.1951 13.388 73.1391 12.996 73.0271 12.724C72.9151 12.452 72.7551 12.316 72.5471 12.316ZM81.354 32.62C80.362 32.62 79.57 32.26 78.978 31.54C78.386 30.82 78.09 29.876 78.09 28.708C78.09 27.428 78.386 26.22 78.978 25.084C79.57 23.932 80.354 23.012 81.33 22.324C82.322 21.62 83.37 21.268 84.474 21.268C84.826 21.268 85.058 21.34 85.17 21.484C85.298 21.612 85.402 21.852 85.482 22.204C85.818 22.14 86.17 22.108 86.538 22.108C87.322 22.108 87.714 22.388 87.714 22.948C87.714 23.284 87.594 24.084 87.354 25.348C86.986 27.188 86.802 28.468 86.802 29.188C86.802 29.428 86.858 29.62 86.97 29.764C87.098 29.908 87.258 29.98 87.45 29.98C87.754 29.98 88.122 29.788 88.554 29.404C88.986 29.004 89.57 28.364 90.306 27.484C90.498 27.26 90.714 27.148 90.954 27.148C91.162 27.148 91.322 27.244 91.434 27.436C91.562 27.628 91.626 27.892 91.626 28.228C91.626 28.868 91.474 29.364 91.17 29.716C90.514 30.532 89.818 31.22 89.082 31.78C88.346 32.34 87.634 32.62 86.946 32.62C86.418 32.62 85.93 32.444 85.482 32.092C85.05 31.724 84.722 31.228 84.498 30.604C83.666 31.948 82.618 32.62 81.354 32.62ZM82.218 30.196C82.57 30.196 82.906 29.988 83.226 29.572C83.546 29.156 83.778 28.604 83.922 27.916L84.81 23.5C84.138 23.516 83.514 23.772 82.938 24.268C82.378 24.748 81.93 25.388 81.594 26.188C81.258 26.988 81.09 27.836 81.09 28.732C81.09 29.228 81.186 29.596 81.378 29.836C81.586 30.076 81.866 30.196 82.218 30.196ZM107.891 27.148C108.099 27.148 108.259 27.244 108.371 27.436C108.499 27.628 108.563 27.892 108.563 28.228C108.563 28.868 108.411 29.364 108.107 29.716C107.419 30.564 106.667 31.26 105.851 31.804C105.035 32.348 104.099 32.62 103.043 32.62C101.091 32.62 99.7314 31.804 98.9634 30.172C98.5474 30.844 97.9954 31.42 97.3074 31.9C96.6194 32.38 95.8834 32.62 95.0994 32.62C93.5794 32.62 92.4594 32.004 91.7394 30.772C91.0354 29.524 90.6834 27.844 90.6834 25.732C90.6834 24.948 90.7234 24.076 90.8034 23.116H89.8194C89.3394 23.116 89.0114 23.028 88.8354 22.852C88.6754 22.676 88.5954 22.396 88.5954 22.012C88.5954 21.116 88.9554 20.668 89.6754 20.668H91.1394C91.4434 18.972 91.8674 17.436 92.4114 16.06C92.9554 14.684 93.6114 13.588 94.3794 12.772C95.1474 11.956 95.9794 11.548 96.8754 11.548C97.5474 11.548 98.0754 11.844 98.4594 12.436C98.8434 13.028 99.0354 13.772 99.0354 14.668C99.0354 16.924 98.1634 18.924 96.4194 20.668H98.6034C98.9074 18.972 99.3314 17.436 99.8754 16.06C100.419 14.684 101.075 13.588 101.843 12.772C102.611 11.956 103.443 11.548 104.339 11.548C105.011 11.548 105.539 11.844 105.923 12.436C106.307 13.028 106.499 13.772 106.499 14.668C106.499 16.924 105.627 18.924 103.883 20.668H106.067C106.323 20.668 106.507 20.724 106.619 20.836C106.731 20.948 106.787 21.156 106.787 21.46C106.787 22.564 105.883 23.116 104.075 23.116H101.171C101.123 23.884 101.099 24.668 101.099 25.468C101.099 27.132 101.291 28.3 101.675 28.972C102.075 29.644 102.699 29.98 103.547 29.98C104.235 29.98 104.843 29.772 105.371 29.356C105.899 28.94 106.523 28.316 107.243 27.484C107.435 27.26 107.651 27.148 107.891 27.148ZM96.2274 13.852C95.9874 13.852 95.7154 14.156 95.4114 14.764C95.1234 15.356 94.8434 16.188 94.5714 17.26C94.3154 18.316 94.0994 19.492 93.9234 20.788C94.8674 19.972 95.5714 19.06 96.0354 18.052C96.5154 17.028 96.7554 16.1 96.7554 15.268C96.7554 14.324 96.5794 13.852 96.2274 13.852ZM103.691 13.852C103.451 13.852 103.179 14.156 102.875 14.764C102.587 15.356 102.307 16.188 102.035 17.26C101.779 18.316 101.563 19.492 101.387 20.788C102.331 19.972 103.035 19.06 103.499 18.052C103.979 17.028 104.219 16.1 104.219 15.268C104.219 14.324 104.043 13.852 103.691 13.852ZM95.6034 29.98C96.0834 29.98 96.5634 29.756 97.0434 29.308C97.5234 28.86 97.9314 28.308 98.2674 27.652C98.1874 27.156 98.1474 26.516 98.1474 25.732C98.1474 24.948 98.1874 24.076 98.2674 23.116H93.7074C93.6594 23.884 93.6354 24.668 93.6354 25.468C93.6354 27.084 93.8034 28.244 94.1394 28.948C94.4914 29.636 94.9794 29.98 95.6034 29.98ZM115.021 21.316C115.389 21.316 115.645 21.364 115.789 21.46C115.933 21.556 116.005 21.716 116.005 21.94C116.005 22.324 115.797 23.692 115.381 26.044C115.013 28.3 114.797 29.636 114.733 30.052C114.141 34.164 113.325 37.42 112.285 39.82C111.245 42.22 109.861 43.42 108.133 43.42C107.317 43.42 106.653 43.164 106.141 42.652C105.629 42.156 105.373 41.5 105.373 40.684C105.373 39.932 105.541 39.164 105.877 38.38C106.229 37.596 106.869 36.692 107.797 35.668C108.741 34.66 110.069 33.5 111.781 32.188L111.853 31.636C111.965 31.044 112.093 30.196 112.237 29.092C111.917 30.244 111.469 31.124 110.893 31.732C110.317 32.324 109.709 32.62 109.069 32.62C108.349 32.62 107.757 32.292 107.293 31.636C106.845 30.964 106.621 30.132 106.621 29.14C106.621 27.94 106.701 26.844 106.861 25.852C107.021 24.844 107.285 23.78 107.653 22.66C107.813 22.18 108.037 21.836 108.325 21.628C108.613 21.42 109.069 21.316 109.693 21.316C110.045 21.316 110.285 21.372 110.413 21.484C110.557 21.596 110.629 21.764 110.629 21.988C110.629 22.116 110.541 22.548 110.365 23.284C110.205 23.876 110.077 24.412 109.981 24.892C109.853 25.548 109.741 26.18 109.645 26.788C109.549 27.38 109.501 27.868 109.501 28.252C109.501 28.86 109.669 29.164 110.005 29.164C110.245 29.164 110.541 28.924 110.893 28.444C111.261 27.964 111.645 27.236 112.045 26.26C112.461 25.284 112.861 24.084 113.245 22.66C113.373 22.18 113.565 21.836 113.821 21.628C114.093 21.42 114.493 21.316 115.021 21.316ZM108.397 41.092C108.797 41.092 109.245 40.628 109.741 39.7C110.237 38.772 110.733 37.228 111.229 35.068C109.997 36.108 109.101 37.052 108.541 37.9C107.997 38.764 107.725 39.516 107.725 40.156C107.725 40.428 107.773 40.652 107.869 40.828C107.981 41.004 108.157 41.092 108.397 41.092Z" fill="white" fill-opacity="0.87"/>
        <defs>
        <clipPath id="clip0_109_2078">
        <rect width="44" height="44" fill="white"/>
        </clipPath>
        </defs>
      </svg>
    </div>
    """
  end
  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)
    {:ok, assign(socket, email: email), temporary_assigns: [email: nil]}
  end
end
