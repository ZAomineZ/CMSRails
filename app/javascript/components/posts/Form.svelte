<script>
    // Libs
    import Tags from 'svelte-tags-input'
    import InputField from "../form/InputField.svelte";
    import TextareaField from "../form/TextareaField.svelte";

    // PROPS
    export let uriForm = ''
    export let post = null
    export let credentials = {
        name: '',
        slug: '',
    }
    export let callInputs = {
        onInputNameField: () => {
        },
        onInputSlugField: () => {
        },
        onInputDescField: () => {
        }
    }
    export let files
</script>

<form action={uriForm} method="POST" on:submit|preventDefault>
    {#if uriForm === '/posts'}
        <input name="_method" type="hidden" value="put">
    {/if}
    <InputField id="name" label="Post Name" on:input={callInputs.onInputNameField} placeHolder="Enter your name..."/>
    <InputField id="slug" label="Post Slug" on:input={callInputs.onInputSlugField} placeHolder="Enter your slug..."/>
    <div class="form-group">
        <label for="categories">Post Categories</label>
        <Tags class="form-control" id="categories" on:tags placeholder="Your categories..."/>
    </div>
    <TextareaField cols="30" id="descr" label="Post Content"
                   noJson={false} on:input={callInputs.onInputDescField}
                   placeHolder="Enter your content"/>
    <InputField bind:files={files} className='custom-file-input' id="image" label="Choose your image" type="file"/>
    <button class="btn btn-primary mt-4" type="submit">Send</button>
</form>