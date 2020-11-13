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

    // DATA
    let csrfValue = null

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
    })
</script>

<form action={uriForm} method="POST">
    <input name="_method" type="hidden" value="put">
    <input name="authenticity_token" type="hidden" value={csrfValue}>
    <InputField id="username" label="Your username" placeHolder='Your username...' type="text"
                value={user.username}/>
    <InputField id="password" label="Your new password ?" placeHolder='Your new password...'
                type="password"/>
    <InputField id="password_confirmation" label="Your new password confirmation ?"
                placeHolder='Your new password confirmation...'
                type="password"/>
    <button class="btn btn-primary" type="submit">Update</button>
</form>