<script>
    // MODULES SVELTE
    import {onMount} from "svelte";

    // Libs
    import Tags from 'svelte-tags-input'
    import InputField from "../form/InputField.svelte";
    import TextareaField from "../form/TextareaField.svelte";

    // PROPS
    export let uriForm = ''
    export let post = null
    export let callInputs = {
        onInputNameField: () => {
        },
        onInputSlugField: () => {
        },
        onInputDescField: () => {
        }
    }
    export let files
    export let categoriesList
    export let errorFields
    export let dataCategories = []

    onMount(() => {
        console.log(post)
    })
</script>

<form action={uriForm} method="POST" on:submit|preventDefault>
    {#if uriForm !== '/posts'}
        <input name="_method" type="hidden" value="put">
    {/if}
    <InputField id="name" label="Post Name" on:input={callInputs.onInputNameField} placeHolder="Enter your name..."
                error={errorFields ? errorFields.name : null} value={post ? post.name : null}/>
    <InputField id="slug" label="Post Slug" on:input={callInputs.onInputSlugField} placeHolder="Enter your slug..."
                error={errorFields ? errorFields.slug : null} value={post ? post.slug : null}/>
    <div class="form-group">
        <label for="categories">Post Categories</label>
        <Tags autoComplete={dataCategories} class="form-control" id="categories" on:tags placeholder="Your categories..."
              tags={categoriesList}/>
    </div>
    <TextareaField cols="30" id="descr" label="Post Content"
                   noJson={false} on:input={callInputs.onInputDescField} valueText={post ? post.descr : null}
                   error={errorFields ? errorFields.descr : null} placeHolder="Enter your content"/>
    <InputField bind:files={files} className='custom-file-input' id="image" label="Choose your image" type="file"/>
    {#if post && post.img_original}
        <div class="form-group img-info">
            <h6 class="img-text">Image Preview:</h6>
            <div class="img-preview">
                <a href="#">
                    <img src={post.img_original.thumb.url ? post.img_original.thumb.url : '/images/default/thumb_image.png'}
                         alt="">
                </a>
            </div>
        </div>
    {/if}
    <button class="btn btn-primary mt-4" type="submit">Send</button>
</form>