TEMPLATE = subdirs

SUBDIRS += \
    app \
    core

core.subdir = core
#core.depends =

app.subdir = app
app.depends = core
