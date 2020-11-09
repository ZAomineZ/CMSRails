<script>
    // MODULE SVELTE
    import {onMount} from "svelte";

    // MODULE HTML
    import InputField from "../form/InputField.svelte";
    import TextareaField from "../form/TextareaField.svelte";

    // PROPS
    export let uriForm = ''
    export let category = null

    // DATA
    let csrfValue = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })
</script>

<form action={uriForm} method="POST">
    {#if uriForm !== '/categories'}
        <input name="_method" type="hidden" value="put">
    {/if}
    <input name="authenticity_token" type="hidden" value={csrfValue}>

    <InputField id="name" label="Category Name" placeHolder="Enter your name..."
                value={category ? category.name : null}/>
    <InputField id="slug" label="Category Slug" placeHolder="Enter your slug..."
                value={category ? category.slug : null}/>

    <TextareaField cols="30" id="resume" label="Category Content"
                   noJson placeHolder="Enter your content" valueText={category ? category.resume : null}/>
    <InputField className='custom-file-input' id="image" label="Choose your image" type="file"/>

    <button class="btn btn-primary mt-4" type="submit">Send</button>
</form>