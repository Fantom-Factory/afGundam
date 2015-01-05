using gfx
using web
using webmod
using wisp

const class WindowMod : WebMod {

	private const Str windowTitle
	private const Size windowSize
	private const Pod[] pods
	private const Type main
	
	new make(Str windowTitle, Size windowSize, Str podCsv, Type main) {
		this.windowTitle = windowTitle
		this.windowSize = windowSize
		this.main = main
		
		pods := [,]
		podCsv.split(',').each |podName| {
			pods.add(Pod.find(podName))
		}
		this.pods = pods
	}

	override Void onGet() {
		name := req.modRel.path.first
		if (name == null)
			onIndex
		else if (name == "pod")
			onPodFile
		else
			res.sendErr(404)
	}

	Void onIndex() {
	    env  := ["fwt.window.root":"fwt-root"]

		res.headers["Content-Type"] = "text/html; charset=utf-8"
		out := res.out
		out.docType
		out.html
		out.head
			out.title.w(windowTitle).titleEnd
			pods.each |pod| { 
				out.includeJs(`/pod/$pod.name/${pod.name}.js`)				
			}
			WebUtil.jsMain(out, main.qname, env)
		out.headEnd		
		out.body
			.div("id='fwt-root' style='position:relative; width:${windowSize.w}px; height:${windowSize.h}px;'").divEnd
		out.bodyEnd
		out.htmlEnd
	}

	Void onPodFile() {
    	// serve up pod resources
    	File file := ("fan://" + req.uri[1..-1]).toUri.get
    	if (!file.exists) { res.sendErr(404); return }
    	FileWeblet(file).onService
   	}
}