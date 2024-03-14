import stanza

# Inicializar el pipeline de procesamiento de Stanza para español
nlp = stanza.Pipeline(lang='es', processors='tokenize,mwt,pos,lemma')

# Función para procesar el texto y guardar los resultados en un archivo
def procesar_texto(input_file, output_file):
    # Abrir el archivo de texto de entrada
    with open(input_file, 'r', encoding='utf-8') as file:
        text = file.read()  # Leer el contenido del archivo
    
    # Procesar el texto usando Stanza
    doc = nlp(text)
    output_path = "C:/Users/ameri/Desktop/5to semestre/pinocho_result.txt"
    # Abrir el archivo de texto de salida para escribir los resultados
    with open(output_path, 'w', encoding='utf-8') as file:
        # Escribir encabezados
        file.write("id:\tPalabra:\tLema:\n")
        
        # Inicializar el contador de palabras
        word_id = 1
        
        # Iterar sobre las oraciones procesadas
        for sentence in doc.sentences:
            # Iterar sobre las palabras tokenizadas y lematizadas en cada oración
            for word in sentence.words:
                # Escribir el ID, la palabra y su lema en el archivo de salida
                file.write(f"{word_id}\t{word.text}\t\t{word.lemma}\n")
                # Incrementar el contador de palabras
                word_id += 1

# Llamar a la función para procesar el texto y guardar los resultados
procesar_texto("C:/Users/ameri/Desktop/5to semestre/pinocho.txt", "pinocho_result.txt")