module Web.View.Users.New where

import Web.View.Prelude

data NewView = NewView {user :: User}

instance View NewView where
    beforeRender view = setLayout signupLayout
    html NewView{..} =
        [hsx|
        <div class="h-100" id="sessions-new">
            <div class="d-flex align-items-center">
                <div class="w-100">
                    <div style="max-width: 400px" class="mx-auto mb-5">
                        <h5>Create account:</h5>
                        {renderForm user}
                    </div>
                </div>
            </div>
        </div>
    |]

renderForm :: User -> Html
renderForm user =
    formFor
        user
        [hsx|
    {(textField #username) {autofocus = True}}
    {(textField #email)}
    {(passwordField #passwordHash) {fieldLabel = "Password"}}
    {(hiddenField #failedLoginAttempts)}
    {submitButton}
|]
