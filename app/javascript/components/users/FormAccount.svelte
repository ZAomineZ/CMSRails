<script>
    // MODULES SVELTE
    import {onMount} from "svelte";
    // MODULES HTML
    import InputField from "../form/InputField.svelte";
    // LIB
    import {RequestDocument} from "../../packs/helper/RequestDocument";

    // PROPS
    export let uriForm = null
    export let user = null
    export let errorFields

    // DATA
    let csrfValue = null

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
        console.log(errorFields)
    })
</script>

<form action={uriForm} method="POST">
    <input name="_method" type="hidden" value="put">
    <input name="authenticity_token" type="hidden" value={csrfValue}>
    <InputField id="username" label="Your username" placeHolder='Your username...' type="text"
                error={errorFields ? errorFields.username : null} value={user.username}/>
    <InputField id="password" label="Your new password ?" placeHolder='Your new password...'
                error={errorFields ? errorFields.password : null} type="password"/>
    <InputField id="password_confirmation" label="Your new password confirmation ?"
                placeHolder='Your new password confirmation...'
                error={errorFields ? errorFields.password_confirmation : null} type="password"/>
    <button class="btn btn-primary" type="submit">Update</button>
</form>