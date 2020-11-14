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

<form action={uriForm} method="POST" enctype="multipart/form-data">
    {#if uriForm !== '/admin/category'}
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
    {#if category && category.avat_cat}
        <div class="form-group img-info">
            <h6 class="img-text">Image Preview:</h6>
            <div class="img-preview">
                <img src={category.avat_cat.url} alt="Category image {category.id}">
            </div>
        </div>
    {/if}
    <button class="btn btn-primary mt-4" type="submit">Send</button>
</form>