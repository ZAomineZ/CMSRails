<script>
    import Header from "./front/layout/Header.svelte";
    import Footer from "./front/layout/Footer.svelte";
    import CategoryListHome from "./front/category/CategoryListHome.svelte";
    import PostListHome from "./front/post/PostListHome.svelte";

    // PROPS
    export let categories_last_4 = []
    export let categories_last_6 = []
    export let posts = []
</script>

<div class="wrap">
    <Header/>
    <div class="content">
        <div class="main-content">
            <div class="region">
                <div class="block-main">
                    <div class="container">
                        <div class="item">
                            <div class="img-right">
                                <img alt="" src="/images/front/winx.jpg">
                            </div>
                            <div class="body-text">
                                Winx Club est une série télévisée mettant en scène des fées à l'école pour apprendre la
                                magie, les enchantements et les potions magiques. Dans le monde de Magix, il existe
                                trois écoles de magie: Alféa, Fontaine Rouge et la Tour Nuage. Graphiquement Winx
                                ressemble beaucoup au manga Sailor Moon.
                                <br>
                                Les personnages principaux de la série sont : Bloom (elle possède le pouvoir magique le
                                plus puissant du monde de Magix, le pouvoir universel de la flamme du dragon). Stella
                                est la fée du soleil et de la lune, elle adore faire du shopping et suit la mode avec
                                attention. Flora a les cheveux chatain et blond, elle est la fée de la nature. Musa a
                                les cheveux bleu marine, c'est la fée de la musique. Layla a les cheveux bruns et le
                                teint mat, elle est la fée des fluides. On n'oublie pas Tecna et ses cheveux roses,
                                c'est la fée de la technologie.
                            </div>
                        </div>
                        <div class="block-view">
                            <h2>Coloriages de Winx</h2>
                            <div class="content">
                                <CategoryListHome categories_last_4={categories_last_4}
                                                  categories_last_6={categories_last_6}/>
                                <div class="block-pub"></div>
                                <PostListHome posts={posts} />
                            </div>
                        </div>
                    </div>
                    <Footer />
                </div>
            </div>
        </div>
    </div>
</div>