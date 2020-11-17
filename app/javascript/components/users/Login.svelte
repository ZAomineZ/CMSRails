<script>
    // MODULES SVELTE
    import {onMount} from "svelte";
    // MODULES HTML
    import InputField from "../form/InputField.svelte";
    import Alert from "../concern/Alert.svelte";
    // LIB
    import {RequestDocument} from "../../packs/helper/RequestDocument";

    // PROPS
    export let successMessage = null
    export let dangerMessage = null
    export let errorFields = null

    // DATA
    let csrfValue

    onMount(() => {
        let body = document.querySelector('body')
        body.classList.add('login-page')

        csrfValue = RequestDocument.getCsrf()
    })
    // METHODS
</script>

<div class="container">
    <div class="row">
        <div class="col-lg-6 col-md-8 col-sm-12 middle-login">
            <div class="card login-block">
                <div class="card-body">
                    <h5 class="card-title">Sign In</h5>
                    {#if successMessage !== null || dangerMessage !== null}
                        <Alert type={successMessage ? 'success' : 'danger'}
                               message={successMessage ? successMessage: dangerMessage}/>
                    {/if}
                    <form action="#" method="POST">
                        <input name="authenticity_token" type="hidden" value={csrfValue}>
                        <InputField className="form-control"
                                    error={errorFields && errorFields.username ? errorFields.username : null}
                                    id="username"
                                    label="Your username" placeHolder="Your username..."
                                    type="text"/>
                        <InputField className="form-control"
                                    error={errorFields && errorFields.password ? errorFields.password : null}
                                    id="password"
                                    label="Your password" placeHolder="Your password..."
                                    type="password"/>
                        <button class="btn btn-primary" type="submit">Sign In</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>