<script>
    import InputField from "../form/InputField.svelte";

    // PROPS
    export let onInput = () => {
    }
    export let uriForm = null
    export let user = null
</script>

<form action={uriForm} method="POST" on:submit|preventDefault>
    <input name="_method" type="hidden" value="put">
    <InputField id="username" label="Your username" on:input={onInput} placeHolder='Your username...' type="text"
                value={user.username}/>
    <InputField id="password" label="Your new password ?" on:input={onInput} placeHolder='Your new password...'
                type="password"/>
    <InputField id="password_confirmation" label="Your new password confirmation ?" on:input={onInput}
                placeHolder='Your new password confirmation...'
                type="password"/>
    <button class="btn btn-primary" type="submit">Update</button>
</form>