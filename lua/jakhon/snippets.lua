local ls = require("luasnip")
local s, i, t = ls.snippet, ls.insert_node, ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
    s(
        "djmodel",
        fmt(
            "class {}(models.Model):\n    {} = models.CharField(max_length={})\n\n    def __str__(self):\n        return str(self.{})",
            { i(1, "ModelName"), i(2, "name"), i(3, "255"), i(4, "name") }
        )
    ),
    s(
        "drfserializer",
        fmt(
            "class {}Serializer(serializers.ModelSerializer):\n    class Meta:\n        model = {}\n        fields = {}",
            { i(1, "Model"), i(2, "Model"), i(3, '"__all__"') }
        )
    ),
    s(
        "drfviewset",
        fmt(
            "class {}ViewSet(viewsets.ModelViewSet):\n    queryset = {}.objects.all()\n    serializer_class = {}Serializer\n    permission_classes = [{}]",
            { i(1, "Model"), i(2, "Model"), i(3, "Model"), i(4, "IsAuthenticated") }
        )
    ),
    s("fastapi", {
        t({
            "from fastapi import FastAPI",
            "",
            "app = FastAPI()",
            "",
            '@app.get("/")',
            "async def root():",
            '    return {"message": "Hello"}',
        }),
    }),
    s(
        "apiroute",
        fmt(
            '@router.{}("{}")\nasync def {}({}):\n    {}',
            { i(1, "get"), i(2, "/items"), i(3, "list_items"), i(4), i(5, "return []") }
        )
    ),
    s("pydmodel", fmt("class {}(BaseModel):\n    {}: {}", { i(1, "Schema"), i(2, "name"), i(3, "str") })),
}, { key = "jakhon-python" })
